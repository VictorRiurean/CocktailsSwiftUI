//
//  IngredientsView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 23/01/2023.
//

import NukeUI
import SwiftUI

struct IngredientView: View {
    
    // MARK: Environment
    
    @Environment(\.colorScheme) var colorScheme
    
    
    // MARK: Private properties
    
    private var ingredient: Ingredient
    
    
    // MARK: Body
    
    var body: some View {
        HStack {
            LazyImage(url: getURL())
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
    
    
    // MARK: Lifecycle
    
    init(ingredient: Ingredient) {
        self.ingredient = ingredient
    }
    
    
    // MARK: Private methods
    
    private func getURL() -> URL? {
        if ingredient.strIngredient1.contains("ejo ") {
            return URL(string: "https://thecocktaildb.com/images/ingredients/A%C3%B1ejo%20rum-Small.png")
        }
        
        return URL(string: IngredientsBaseURL.url + ingredient.urlString.lowercased().trimmingCharacters(in: .whitespaces) + IngredientsBaseURL.suffix)
    }
}

struct IngredientView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientView(ingredient: Ingredient(strIngredient1: "Rum"))
    }
}
