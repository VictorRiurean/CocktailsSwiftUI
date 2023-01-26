//
//  Drink.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 19/01/2023.
//

import Foundation

struct Drinks: Codable {
    var drinks: [Drink]
}

struct Drink: Codable, Identifiable, Equatable {
    let id = UUID()
    var strDrink: String
    var strCategory: String?
    var strAlcoholic: String?
    var strGlass: String?
    var strInstructions: String?
    var strDrinkThumb: String?
    var strImageSource: String?
    var strIngredient1: String?
    var strIngredient2: String?
    var strIngredient3: String?
    var strIngredient4: String?
    var strIngredient5: String?
    var strIngredient6: String?
    var strIngredient7: String?
    var strIngredient8: String?
    var strIngredient9: String?
    var strIngredient10: String?
    var strIngredient11: String?
    var strIngredient12: String?
    var strIngredient13: String?
    var strIngredient14: String?
    var strIngredient15: String?
    var strMeasure1: String?
    var strMeasure2: String?
    var strMeasure3: String?
    var strMeasure4: String?
    var strMeasure5: String?
    var strMeasure6: String?
    var strMeasure7: String?
    var strMeasure8: String?
    var strMeasure9: String?
    var strMeasure10: String?
    var strMeasure11: String?
    var strMeasure12: String?
    var strMeasure13: String?
    var strMeasure14: String?
    var strMeasure15: String?
    var isFavourite: Bool? = false
    var idDrink: String?
    
    lazy var ingredients: [String] = {
        [
            strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5,
            strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10,
            strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15
        ].compactMap { $0 }
    }()
    lazy var measures: [String] = {
        [
            strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5,
            strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10,
            strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15
        ].compactMap { $0 }
    }()
    lazy var ingredientsAndMesaures: [IngredientAndMeasure] = {
        var array: [IngredientAndMeasure] = []
        
        for i in 0..<ingredients.count {
            array.append(IngredientAndMeasure(ingredient: ingredients[i], measure: i < measures.count ? measures[i] : ""))
        }
        
        return array
    }()
    
    static let surprizeMe: Drink = Drink(strDrink: "Surprize me!", strCategory: "", strAlcoholic: "", strGlass: "")
    static let noDrinkForYou: Drink = Drink(strDrink: "No drink for this letter 🙃", strIngredient1: "Somebody should do something about this ...")
    
    func unwrappedFavourite() -> Bool {
        return isFavourite ?? false
    }
}
