//
//  ListView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

struct CocktailsView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.strDrink, order: .forward)]) var cocktails: FetchedResults<Cocktail>
    
    @AppStorage(StorageKeys.allLettersLoaded.rawValue) var allLettersLoaded: Bool = false
    @AppStorage(StorageKeys.loadedLetters.rawValue) var loadedLetters: Data = Data()
    
    @State private var searchText = ""
    
    @ObservedObject private var viewModel = CocktailsViewModel()
    
    private var letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    private var searchResults: [Cocktail] {
        if searchText.isEmpty {
            return Array(cocktails)
        } else {
            return cocktails.filter { $0.unwrappedDrink.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationStack {
            List(Storage.loadStringArray(data: loadedLetters), id: \.self) { letter in
                Section(header: Text(letter)) {
                    ForEach(searchResults.filter { $0.unwrappedDrink.lowercased().starts(with: letter.lowercased()) } ) { drink in
                        ZStack(alignment: .leading) {
                            NavigationLink(destination: CocktailDetailsView(drink: Drink(strDrink: drink.unwrappedDrink, strDrinkThumb: drink.unwrappedThumbnail))) { }
                                .opacity(0)

                            CocktailCellView(drinkName: drink.unwrappedDrink)
                                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))

                        }
                    }
                }
                
                if !allLettersLoaded {
                    ProgressView()
                        .progressViewStyle(MyActivityIndicator())
                        .onAppear {
                            Task {
                                let drinks = await viewModel.fetchDrinks(loadedLetters: Storage.loadStringArray(data: loadedLetters))

                                viewModel.addDrinksToCoreData(drinks: drinks, context: moc)

                                loadedLetters = Storage.archiveStringArray(object: viewModel.loadedLetters)
                                allLettersLoaded = viewModel.allLettersLoaded
                            }
                        }
                }
            }
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
            .navigationTitle("Cocktails")
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        CocktailsView()
    }
}
