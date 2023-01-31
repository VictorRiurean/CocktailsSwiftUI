//
//  ListView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

struct CocktailsView: View {
    
    @State private var drinks: [String: [Drink]] = [:]
    @State private var showDrink: UUID?
    @State private var searchText = ""
    
    private var letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    private var searchResults: [String: [Drink]] {
        if searchText.isEmpty {
            return drinks
        } else {
            var filtered: [String: [Drink]] = [:]
            
            viewModel.loadedLetters.forEach {
                filtered[$0] = drinks[$0]?.filter { $0.strDrink.lowercased().contains(searchText.lowercased()) }
            }
            
            return filtered
        }
    }
    
    @ObservedObject private var viewModel = CocktailsViewModel()
    
    var body: some View {
        NavigationStack {
            if drinks["a"] == nil {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .gray))
            } else {
                List {
                    ForEach(viewModel.loadedLetters, id: \.self) { letter in
                        Section(header: Text(letter)) {
                            if searchResults[letter] == nil {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                            } else {
                                if searchResults[letter]!.isEmpty {
                                    Text("It seems this cocktail is not in the list. 😔")
                                } else {
//                                    LazyVStack {
                                    /// Normally this would be wrapped inside a LazyVStack in order to not get the
                                    /// wonky cell behaviour of images loading but then not being cached properly and
                                    /// also not refreshing as they should once the image is loaded. Unfortunately
                                    /// at the time of writing this code wrapping this in a LazyVStack breaks the navigation.
                                    /// Namely, it pushes a lot of destination views on the navigation stack.
                                        ForEach(searchResults[letter]!) { drink in
                                            ZStack(alignment: .leading) {
                                                NavigationLink(value: drink) { }
                                                
                                                CocktailCellView(drink: drink)
                                                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                                            }
                                        }
//                                    }
                                }
                            }
                        }
                    }
                    
                    if !viewModel.allLettersLoaded {
                        ProgressView()
                        /// I had to go for a custom progressViewStyle because of the fact that
                        /// the native ones were buggy. It should be replaced once the bug is fixed.
                            .progressViewStyle(MyActivityIndicator())
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    Task {
                                        let newDrinks = await viewModel.fetchDrinks()
                                        
                                        drinks[viewModel.currentLetter] = newDrinks
                                    }
                                }
                                
                            }
                    }
                }
                .navigationDestination(for: Drink.self) { drink in
                    CocktailDetailsView(drink: drink)
                }
                .navigationTitle("Cocktails")
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onAppear {
            Task {
                if !viewModel.allLettersLoaded {
                    drinks[viewModel.currentLetter] = await viewModel.fetchDrinks()
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        CocktailsView()
    }
}
