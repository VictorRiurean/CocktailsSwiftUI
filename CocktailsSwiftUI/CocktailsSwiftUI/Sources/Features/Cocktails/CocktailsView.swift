//
//  ListView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

struct CocktailsView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var cocktails: FetchedResults<Cocktail>
    
    @AppStorage(StorageKeys.allLettersLoaded.rawValue) var allLettersLoaded: Bool = false
    
    @State private var searchText = ""
    
    @ObservedObject private var viewModel = CocktailsViewModel()
    
    private var letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
//    private var searchResults: [String: [Drink]] {
//        if searchText.isEmpty {
//            return drinks
//        } else {
//            var filtered: [String: [Drink]] = [:]
//
//            viewModel.loadedLetters.forEach {
//                filtered[$0] = drinks[$0]?.filter { $0.strDrink.lowercased().contains(searchText.lowercased()) }
//            }
//
//            return filtered
//        }
//    }
    
    var body: some View {
        NavigationStack {
            List(viewModel.loadedLetters, id: \.self) { letter in
                Section(header: Text(letter)) {
                    ForEach(cocktails.filter { $0.strDrink?.lowercased().starts(with: letter.lowercased()) ?? false } ) { drink in
                        ZStack(alignment: .leading) {
                            NavigationLink(destination: CocktailDetailsView(drink: Drink(strDrink: drink.unwrappedDrink, strDrinkThumb: drink.unwrappedThumbnail))) { }
                                .opacity(0)

                            CocktailCellView(drinkName: drink.unwrappedDrink)
                                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))

                        }
                    }
                }
                
                if !viewModel.allLettersLoaded {
                    ProgressView()
                        .progressViewStyle(MyActivityIndicator())
                        .onAppear {
                            Task {
                                let drinks = await viewModel.fetchDrinks()
                                
                                viewModel.addDrinksToCoreData(drinks: drinks, context: moc)
                            }
                        }
                }
            }
            .onAppear {
                Task {
                    let drinks = await viewModel.fetchDrinks()
                    
                    viewModel.addDrinksToCoreData(drinks: drinks, context: moc)
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
