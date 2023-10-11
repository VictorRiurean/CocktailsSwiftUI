//
//  Cocktail.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 04/10/2023.
//
//

import SwiftData
import UIKit


@Model public class Cocktail {
    public var id: UUID = UUID()
    var idDrink: String = ""
    @Attribute(.transformable(by: UIImageTransformer.self)) var image: UIImage?
    var isFavourite: Bool = false
    var order: Int16 = 0
    var strAlcoholic: String = ""
    var strCategory: String = ""
    @Attribute(.unique) var strDrink: String = ""
    var strDrinkThumb: String = ""
    var strGlass: String = ""
    var strImageSource: String = ""
    var strInstructions: String = ""
    @Relationship(inverse: \Component.cocktail) var ingredient: [Component] = []

    public init() { }
    
    public init(response: CocktailResponse, modelContext: ModelContext) {
        self.id = response.id
        self.idDrink = response.idDrink ?? ""
        self.strDrink = response.strDrink
        self.strGlass = response.strGlass ?? ""
        self.strCategory = response.strCategory ?? ""
        self.strAlcoholic = response.strAlcoholic ?? ""
        self.strInstructions = response.strInstructions ?? ""
        self.strImageSource = response.strImageSource ?? ""
        self.strDrinkThumb = response.strDrinkThumb ?? ""
        self.isFavourite = false
        self.ingredient = []
        
        if let _ = response.strIngredient1 {
            let component = Component()
            
            modelContext.insert(component)
            
            component.name = response.strIngredient1 ?? ""
            component.measure = response.strMeasure1 ?? ""
            component.cocktail = self
        }
        
        if let _ = response.strIngredient2 {
            let component = Component()
            
            modelContext.insert(component)
            
            component.name = response.strIngredient2 ?? ""
            component.measure = response.strMeasure2 ?? ""
            component.cocktail = self
        }
        
        if let _ = response.strIngredient3 {
            let component = Component()
            
            modelContext.insert(component)
            
            component.name = response.strIngredient3 ?? ""
            component.measure = response.strMeasure3 ?? ""
            component.cocktail = self
        }
        
        if let _ = response.strIngredient4 {
            let component = Component()
            
            modelContext.insert(component)
            
            component.name = response.strIngredient4 ?? ""
            component.measure = response.strMeasure4 ?? ""
            component.cocktail = self
        }
        
        if let _ = response.strIngredient5 {
            let component = Component()
            
            modelContext.insert(component)
            
            component.name = response.strIngredient5 ?? ""
            component.measure = response.strMeasure5 ?? ""
            component.cocktail = self
        }
        
        if let _ = response.strIngredient6 {
            let component = Component()
            
            modelContext.insert(component)
            
            component.name = response.strIngredient6 ?? ""
            component.measure = response.strMeasure6 ?? ""
            component.cocktail = self
        }
        
        if let _ = response.strIngredient7 {
            let component = Component()
            
            modelContext.insert(component)
            
            component.name = response.strIngredient7 ?? ""
            component.measure = response.strMeasure7 ?? ""
            component.cocktail = self
        }
        
        if let _ = response.strIngredient8 {
            let component = Component()
            
            modelContext.insert(component)
            
            component.name = response.strIngredient8 ?? ""
            component.measure = response.strMeasure8 ?? ""
            component.cocktail = self
        }
        
        if let _ = response.strIngredient9 {
            let component = Component()
            
            modelContext.insert(component)
            
            component.name = response.strIngredient9 ?? ""
            component.measure = response.strMeasure9 ?? ""
            component.cocktail = self
        }
        
        if let _ = response.strIngredient10 {
            let component = Component()
            
            modelContext.insert(component)
            
            component.name = response.strIngredient10 ?? ""
            component.measure = response.strMeasure10 ?? ""
            component.cocktail = self
        }
        
        if let _ = response.strIngredient11 {
            let component = Component()
            
            modelContext.insert(component)
            
            component.name = response.strIngredient11 ?? ""
            component.measure = response.strMeasure11 ?? ""
            component.cocktail = self
        }
        
        if let _ = response.strIngredient12 {
            let component = Component()
            
            modelContext.insert(component)
            
            component.name = response.strIngredient12 ?? ""
            component.measure = response.strMeasure12 ?? ""
            component.cocktail = self
        }
        
        if let _ = response.strIngredient13 {
            let component = Component()
            
            modelContext.insert(component)
            
            component.name = response.strIngredient13 ?? ""
            component.measure = response.strMeasure13 ?? ""
            component.cocktail = self
        }
        
        if let _ = response.strIngredient14 {
            let component = Component()
            
            modelContext.insert(component)
            
            component.name = response.strIngredient14 ?? ""
            component.measure = response.strMeasure14 ?? ""
            component.cocktail = self
        }
        
        if let _ = response.strIngredient15 {
            let component = Component()
            
            modelContext.insert(component)
            
            component.name = response.strIngredient15 ?? ""
            component.measure = response.strMeasure15 ?? ""
            component.cocktail = self
        }
    }
    
    public func getIngredientsForCellDescription() -> String {
        var description = ""
        
        if ingredient.count < 4 {
            for index in 0..<ingredient.count {
                description += ingredient[index].name.lowercased()
                
                if index < ingredient.count - 1 {
                    description += ", "
                }
            }
        } else {
            for index in 0..<4 {
                description += ingredient[index].name.lowercased() + ", "
            }
            
            description += "and more ..."
        }
        
        return description
    }
    
    public func getShareMessageString() -> String {
        var message = ""
        
        message += strDrink + "\n\n"
        message += "Ingredients: \n\n"
        
        ingredient.forEach { message += "- " + $0.name.lowercased() + "\n" }
        
        message += "\n" + strInstructions
        
        return message
    }
}
