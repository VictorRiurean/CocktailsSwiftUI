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

struct Drink: Codable, Identifiable {
    let id = UUID()
    var strDrink: String
    var strCategory: String
    var strAlcoholic: String
    var strGlass: String
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
    
    static let surprizeMe: Drink = Drink(strDrink: "Surprize me!", strCategory: "", strAlcoholic: "", strGlass: "")
    
    func unwrappedFavourite() -> Bool {
        return isFavourite ?? false
    }
}
