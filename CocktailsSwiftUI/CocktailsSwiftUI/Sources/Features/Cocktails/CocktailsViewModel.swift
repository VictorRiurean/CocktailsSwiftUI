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
    var loadedLetters: [String] = []
    
    
    // MARK: Public properties
    
    var allLettersLoaded = false
    var currentLetter = "a"
    
    
    // MARK: Private properties
    
    private let service = WebService.shared
    
    private var letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    
    
    // MARK: Public methods
    
    @MainActor
    func fetchDrinks(loadedLetters: [String]) async -> [CocktailResponse] {
        guard !isLoading else { return [] }
        
        isLoading = true
        
        var drinks: [CocktailResponse] = []
        
        self.loadedLetters = loadedLetters
        
        loadedLetters.forEach { letter in
            letters = letters.filter { $0 != letter }
        }
        
        if !letters.isEmpty {
            drinks = await service.fetchDrinks(with: letters.first!)
            
            currentLetter = letters[0]
            
            self.loadedLetters.append(currentLetter)
            
            letters.removeFirst()
        }
        
        allLettersLoaded = letters.isEmpty
        
        if drinks.isEmpty {
            if currentLetter == "u" {
                drinks.append(CocktailResponse.noDrinkForU)
            } else if currentLetter == "x" {
                drinks.append(CocktailResponse.noDrinkForX)
            }
        }
        
        isLoading = false
        
        return drinks
    }
}
