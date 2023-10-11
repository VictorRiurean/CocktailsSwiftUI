//
//  GlassesDetailsViewModel.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 25/01/2023.
//

import Foundation

struct GlassesDetailsViewModel {
    
    // MARK: Private properties
    
    let service = WebService.shared
    
    
    // MARK: Public functions
    
    func fetchDrinks(glass: String) async -> [CocktailResponse] {
        await service.fetchByGlass(name: glass)
    }
}
