//
//  CocktailsViewModel.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 19/01/2023.
//

import Foundation

struct CocktailsViewModel {
    
    // MARK: Private properties
    
    private let service = WebService.shared
    
    
    // MARK: Public methods
    
    func fetchDrinks(startingWith letter: Character) async -> [Drink] {
        await service.fetchDrinks(startingWith: letter)
    }
}
