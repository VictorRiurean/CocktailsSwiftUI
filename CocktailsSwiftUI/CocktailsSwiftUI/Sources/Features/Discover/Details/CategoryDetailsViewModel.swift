//
//  CategoryDetailsViewModel.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 24/01/2023.
//

import Foundation

struct CategoryDetailsViewModel {
    
    // MARK: Private properties
    
    let service = WebService.shared
    
    
    // MARK: Public functions
    
    func fetchDrinks(category: String) async -> [Drink] {
        await service.fetchByCategory(name: category)
    }
}
