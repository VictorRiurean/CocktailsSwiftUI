//
//  CocktailDetailsViewModel.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 24/01/2023.
//

import Foundation

struct CocktailDetailsViewModel {
    
    // MARK: Private properties
    
    private let service = WebService.shared
    
    
    // MARK: Public methods
    
    func fetchDrink(name: String) async -> Drink {
        await service.fetchDrink(with: name)
    }
}
