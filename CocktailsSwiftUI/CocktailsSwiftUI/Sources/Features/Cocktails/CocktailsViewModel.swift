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
        
//        addDrinksToCoreData(drinks: drinks)
        
        return drinks
    }
    
    func addDrinksToCoreData(drinks: [Drink], context: NSManagedObjectContext) {
        drinks.forEach { drink in
            let cocktail = Cocktail(context: context)
            
            cocktail.id = drink.id
            cocktail.strDrink = drink.strDrink
            cocktail.strGlass = drink.strGlass
            cocktail.strCategory = drink.strCategory
            cocktail.strAlcoholic = drink.strAlcoholic
            cocktail.strInstructions = drink.strInstructions
            cocktail.strImageSource = drink.strImageSource
            cocktail.strDrinkThumb = drink.strDrinkThumb
            
            if let _ = drink.strIngredient1 {
                let component = Component(context: context)
                
                component.name = drink.strIngredient1
                component.measure = drink.strMeasure1
                component.cocktail = cocktail
            }
            
            if let _ = drink.strIngredient2 {
                let component = Component(context: context)
                
                component.name = drink.strIngredient2
                component.measure = drink.strMeasure2
                component.cocktail = cocktail
            }
            
            if let _ = drink.strIngredient3 {
                let component = Component(context: context)
                
                component.name = drink.strIngredient3
                component.measure = drink.strMeasure3
                component.cocktail = cocktail
            }
            
            if let _ = drink.strIngredient4 {
                let component = Component(context: context)
                
                component.name = drink.strIngredient4
                component.measure = drink.strMeasure4
                component.cocktail = cocktail
            }
            
            if let _ = drink.strIngredient5 {
                let component = Component(context: context)
                
                component.name = drink.strIngredient5
                component.measure = drink.strMeasure5
                component.cocktail = cocktail
            }
            
            if let _ = drink.strIngredient6 {
                let component = Component(context: context)
                
                component.name = drink.strIngredient6
                component.measure = drink.strMeasure6
                component.cocktail = cocktail
            }
            
            if let _ = drink.strIngredient7 {
                let component = Component(context: context)
                
                component.name = drink.strIngredient7
                component.measure = drink.strMeasure7
                component.cocktail = cocktail
            }
            
            if let _ = drink.strIngredient8 {
                let component = Component(context: context)
                
                component.name = drink.strIngredient8
                component.measure = drink.strMeasure8
                component.cocktail = cocktail
            }
            
            if let _ = drink.strIngredient9 {
                let component = Component(context: context)
                
                component.name = drink.strIngredient9
                component.measure = drink.strMeasure9
                component.cocktail = cocktail
            }
            
            if let _ = drink.strIngredient10 {
                let component = Component(context: context)
                
                component.name = drink.strIngredient10
                component.measure = drink.strMeasure10
                component.cocktail = cocktail
            }
            
            if let _ = drink.strIngredient11 {
                let component = Component(context: context)
                
                component.name = drink.strIngredient11
                component.measure = drink.strMeasure11
                component.cocktail = cocktail
            }
            
            if let _ = drink.strIngredient12 {
                let component = Component(context: context)
                
                component.name = drink.strIngredient12
                component.measure = drink.strMeasure12
                component.cocktail = cocktail
            }
            
            if let _ = drink.strIngredient13 {
                let component = Component(context: context)
                
                component.name = drink.strIngredient13
                component.measure = drink.strMeasure13
                component.cocktail = cocktail
            }
            
            if let _ = drink.strIngredient14 {
                let component = Component(context: context)
                
                component.name = drink.strIngredient14
                component.measure = drink.strMeasure14
                component.cocktail = cocktail
            }
            
            if let _ = drink.strIngredient15 {
                let component = Component(context: context)
                
                component.name = drink.strIngredient15
                component.measure = drink.strMeasure15
                component.cocktail = cocktail
            }
            
            try? context.save()
        }
    }
}
