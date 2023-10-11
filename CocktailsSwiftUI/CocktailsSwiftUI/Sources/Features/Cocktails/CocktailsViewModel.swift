//
//  CocktailsViewModel.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 19/01/2023.
//

import CoreData
import Observation
import SwiftUI


@Observable
class CocktailsViewModel {
    
    // MARK: State
    
    var isLoading = false
    
    
    // MARK: Public properties
    
    var allLettersLoaded = false
    var letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    
    
    // MARK: Private properties
    
     let service = WebService.shared
    
    
    // MARK: Public methods
    
    func fetchDrinks() async -> [CocktailResponse] {
        guard !isLoading else { return [] }
        
        isLoading = true
        
        var drinks: [CocktailResponse] = []
        
        drinks = await withTaskGroup(of: CocktailResponse.self, returning: [CocktailResponse].self) { taskGroup in
            var drinks = [CocktailResponse]()
            
            for letter in letters {
                taskGroup.addTask { await self.service.fetchDrink(with: letter) }
            }
            
            for await result in taskGroup {
                drinks.append(result)
            }
            
            return drinks
        }
        
        drinks.append(CocktailResponse.noDrinkForU)
        drinks.append(CocktailResponse.noDrinkForX)
        
        isLoading = false
        
        return drinks
    }
}
