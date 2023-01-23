//
//  GlassesViewModel.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 23/01/2023.
//

import Foundation

struct GlassesViewModel {
    
    // MARK: Private properties
    
    let service = WebService.shared
    
    
    // MARK: Public functions
    
    func fetchGlasses() async -> [Glass] {
        await service.fetchGlasses()
    }
}
