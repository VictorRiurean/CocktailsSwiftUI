//
//  IngredientsViewModel.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 23/01/2023.
//

import Foundation

struct IngredientsViewModel {
    
    // MARK: Private properties
    
    let service = WebService.shared
    
    
    // MARK: Public functions
    
    func fetchIngredients() async -> [Ingredient] {
        await service.fetchIngredients()
    }
}
