//
//  IngredientsView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

struct IngredientsView: View {
    
    @State private var ingredients: [Ingredient] = []
    @State private var searchText: String = ""
    
    private let viewModel = IngredientsViewModel()
    
    private var searchResults: [Ingredient] {
        if searchText.isEmpty {
            return ingredients
        } else {
            return ingredients.filter {
                $0.strIngredient1.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            if ingredients.isEmpty {
                ProgressView()
                    .progressViewStyle(DefaultProgressViewStyle())
            } else {
                List {
                    if searchResults.isEmpty {
                        Text("It seems this ingredient is not in the list. 😔")
                    } else {
                        ForEach(searchResults) { ingredient in
                            ZStack {
                                NavigationLink(destination: IngredientsDetailsView(ingredient: ingredient.strIngredient1)) { }
                                
                                IngredientView(ingredient: ingredient)
                            }
                            
                        }
                    }
                }
                .navigationTitle("Ingredients")
            }
        }
        .onAppear {
            Task {
                ingredients = await viewModel.fetchIngredients()
                ingredients.forEach {
                    if $0.strIngredient1.contains("ejo rum") {
                        // TODO:
                        print("Debug this: \($0.urlString)")
                    }
                }
            }
        }
        .searchable(text: $searchText)
    }
}

struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView()
    }
}
