//
//  CocktailsViewModel.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 19/01/2023.
//

import Foundation

@MainActor
class CocktailsViewModel: ObservableObject {
    
    // MARK: Public properties
    
    @Published var isLoading = false
    @Published var loadedLetters: [String] = []
    
    var allLettersLoaded = false
    var currentLetter = "a"
    
    
    // MARK: Private properties
    
    private let service = WebService.shared
//    private var letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    private var letters = ["a", "u", "v", "z"]
    
    
    // MARK: Public methods
    
    @MainActor
    func fetchDrinks() async -> [Drink] {
        isLoading = true
        
        var drinks: [Drink] = []
        
        if !letters.isEmpty {
            drinks = await service.fetchDrinks(startingWith: Character(letters.first!))
            
            currentLetter = letters[0]

            loadedLetters.append(currentLetter)

            letters.removeFirst()
        }
        
        allLettersLoaded = letters.isEmpty
        
        if drinks.isEmpty {
            drinks.append(Drink.noDrinkForYou)
        }
        
        isLoading = false
        
        return drinks
    }
}
