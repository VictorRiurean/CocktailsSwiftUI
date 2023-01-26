//
//  ListView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

struct CocktailsView: View {
    
    @State private var drinks: [String: [Drink]] = [:]
    @State private var searchText = ""
    
    private var letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    
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
                            if drinks[letter] == nil {
                                EmptyView()
                            } else {
                                if drinks[letter]!.isEmpty {
                                    EmptyView()
                                } else {
                                    LazyVStack {
                                        ForEach(drinks[letter]!) { drink in
                                            ZStack(alignment: .leading) {
                                                NavigationLink(destination: CocktailDetailsView(drink: drink)) { }
                                                
                                                CocktailCellView(drink: drink)
                                                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    if !viewModel.allLettersLoaded {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .gray))
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
                .navigationTitle("Cocktails")
            }
            
        }
        .searchable(text: $searchText)
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
