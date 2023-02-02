//
//  CocktailsViewModel.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 19/01/2023.
//

import CoreData
import SwiftUI

@MainActor
class CocktailsViewModel: ObservableObject {
    
    // MARK: State
    
    @Published var isLoading = false
    @Published var loadedLetters: [String] = []
    
    
    // MARK: Public properties
    
    var allLettersLoaded = false
    var currentLetter = "a"
    
    
    // MARK: Private properties
    
    private let service = WebService.shared
    private let databaseManager = DatabaseManager.shared
    
    private var letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    
    
    // MARK: Public methods
    
    @MainActor
    func fetchDrinks(loadedLetters: [String]) async -> [Drink] {
        guard !isLoading else { return [] }
        
        isLoading = true
        
        var drinks: [Drink] = []
        
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
                drinks.append(Drink.noDrinkForU)
            } else if currentLetter == "x" {
                drinks.append(Drink.noDrinkForX)
            }
        }
        
        isLoading = false
        
        return drinks
    }
    
    func addDrinksToCoreData(drinks: [Drink], context: NSManagedObjectContext) {
        databaseManager.addDrinksToCoreData(drinks: drinks, context: context)
    }
}
