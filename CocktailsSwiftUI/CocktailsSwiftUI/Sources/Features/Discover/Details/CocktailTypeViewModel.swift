//
//  CocktailTypeViewModel.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 24/01/2023.
//

import Foundation

struct CocktailTypeViewModel {
    
    // MARK: Private properties
    
    let service = WebService.shared
    
    
    // MARK: Public functions
    
    func fetchDrinks(with type: DrinkType) async -> [Drnk] {
        await service.fetchDrinks(with: type)
    }
}
