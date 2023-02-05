//
//  ListView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

struct CocktailsView: View {
    
    // MARK: Environment
    
    @Environment(\.managedObjectContext) var moc
    
    
    // MARK: FetchRequests
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.strDrink, order: .forward)]) var cocktails: FetchedResults<Cocktail>
    
    
    // MARK: Storage
    
    @AppStorage(StorageKeys.allLettersLoaded.rawValue) var allLettersLoaded: Bool = false
    @AppStorage(StorageKeys.loadedLetters.rawValue) var loadedLetters: Data = Data()
    
    
    // MARK: State
    
    @State private var searchText = ""
    @State private var drinkName = ""
    @State private var isShowingRandomCocktail = false
    
    @ObservedObject private var viewModel = CocktailsViewModel()
    
    
    // MARK: Private properties
    
    private var searchResults: [Cocktail] {
        if searchText.isEmpty {
            return Array(cocktails)
        } else {
            return cocktails.filter { $0.unwrappedDrink.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    
    // MARK: Body
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(Storage.loadStringArray(data: loadedLetters), id: \.self) { letter in
                    Section(header: Text(letter)) {
                        LazyVStack {
                            ForEach(searchResults.filter { $0.unwrappedDrink.lowercased().starts(with: letter) }) { cocktail in
                                /// This was the only navigation that was working properly with LazyVStack
                                CocktailCellView(drinkName: cocktail.unwrappedDrink, letter: letter)
                                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                                    .onTapGesture {
                                        drinkName = cocktail.unwrappedDrink
                                        isShowingRandomCocktail = true
                                    }
                                    .navigationDestination(isPresented: $isShowingRandomCocktail) {
                                        CocktailDetailsView(name: drinkName)
                                    }
                            }
                        }
                    }
                }
                
                if !allLettersLoaded {
                    ProgressView()
                        .progressViewStyle(MyActivityIndicator())
                        /// onAppear is very trigger-happy. It sets off ages before the view is actually shown
                        /// so I had to add all the pizzazz below to prevent the app being stuck while spinner
                        /// goes BRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                Task {
                                    await fetchDrinks()
                                }
                            }
                            
                            /// This is meant to handle the scenario in which the spinner is showing
                            /// but for some reason onAppear was not called again on redraw.
                            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                                if !allLettersLoaded {
                                    Task {
                                        await fetchDrinks()
                                    }
                                }
                            }
                        }
                }
            }
            .navigationTitle("Cocktails")
        }
        
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onAppear {
            if !allLettersLoaded {
                Task {
                    let drinks = await viewModel.fetchDrinks(loadedLetters: Storage.loadStringArray(data: loadedLetters))
                    
                    viewModel.addDrinksToCoreData(drinks: drinks, context: moc)
                    
                    loadedLetters = Storage.archiveStringArray(object: viewModel.loadedLetters)
                    allLettersLoaded = viewModel.allLettersLoaded
                }
            }
        }
    }
    
    
    // MARK: Private methods
    
    private func fetchDrinks() async {
        let drinks = await viewModel.fetchDrinks(loadedLetters: Storage.loadStringArray(data: loadedLetters))
        
        if !drinks.isEmpty {
            viewModel.addDrinksToCoreData(drinks: drinks, context: moc)
            
            loadedLetters = Storage.archiveStringArray(object: viewModel.loadedLetters)
            allLettersLoaded = viewModel.allLettersLoaded
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        CocktailsView()
    }
}
