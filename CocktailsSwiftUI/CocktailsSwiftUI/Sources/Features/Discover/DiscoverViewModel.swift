//
//  DiscoverViewModel.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 19/01/2023.
//

import Foundation

struct DiscoverViewModel {
    
    // MARK: Private properties
    
    let service = WebService.shared
    
    
    // MARK: Public functions
    
    func fetchCategories() async -> [Category] {
        await service.fetchCategories()
    }
    
    func fetchRandomCocktail() async -> CocktailResponse {
        await service.fetchRandomCocktail()
    }
}
