//
//  IngredientsView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

struct IngredientsView: View {
    
    private let viewModel = IngredientsViewModel()
    
    @State private var ingredients: [Ingredient] = []
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(ingredients) { ingredient in
                    ZStack {
                        NavigationLink(destination: IngredientsDetailsView(ingredient: ingredient.strIngredient1)) { }
                        
                        IngredientView(ingredient: ingredient)
                    }
                    
                }
            }
            .navigationTitle("Ingredients")
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
