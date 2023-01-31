//
//  IngredientsView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 23/01/2023.
//

import NukeUI
import SwiftUI

struct IngredientView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    private var ingredient: Ingredient
    
    var body: some View {
        HStack {
            LazyImage(url: URL(string: IngredientsBaseURL.url + ingredient.urlString.lowercased().trimmingCharacters(in: .whitespaces) + IngredientsBaseURL.suffix))
                .frame(width: 70, height: 70)
                .padding()
            
            Text(ingredient.strIngredient1)
                .font(.headline)
            
            Spacer()
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(colorScheme == .light ? AppColors.getRandomLightColor() : AppColors.getRandomDarkColor())
        .cornerRadius(15)
    }
    
    init(ingredient: Ingredient) {
        self.ingredient = ingredient
    }
}

struct IngredientView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientView(ingredient: Ingredient(strIngredient1: "Rum"))
    }
}
