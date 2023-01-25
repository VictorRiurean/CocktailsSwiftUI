//
//  IngredientsDetailsViewModel.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 25/01/2023.
//

import Foundation

struct IngredientsDetailsViewModel {
    
    // MARK: Private properties
    
    let service = WebService.shared
    
    
    // MARK: Public functions
    
    func fetchDrinks(ingredient: String) async -> [Drink] {
        await service.fetchByIngredient(name: ingredient)
    }
}
