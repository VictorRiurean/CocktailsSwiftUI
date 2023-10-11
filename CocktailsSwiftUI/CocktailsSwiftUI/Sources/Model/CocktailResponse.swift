//
//  Drink.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 19/01/2023.
//

import Foundation


struct Drinks: Codable {
    var drinks: [CocktailResponse]
}


public struct CocktailResponse: Codable, Identifiable, Equatable, Hashable {
    
    // MARK: Properties
    
    public let id = UUID()
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
    
    static let surprizeMe: CocktailResponse = CocktailResponse(strDrink: "Surprise me!", strIngredient1: "Tap this to get a random cocktail!")
    static let noDrinkForU: CocktailResponse = CocktailResponse(strDrink: "Unforunately there's no drink for U 🙃", strIngredient1: "Somebody should do something about this ...")
    static let noDrinkForX: CocktailResponse = CocktailResponse(strDrink: "X is also a letter with no drinks 😭", strIngredient1: "Somebody should do something about this ...")
    
    
    // MARK: CodingKeys
    
    enum CodingKeys: CodingKey {
        case id
        case strDrink
        case strCategory
        case strAlcoholic
        case strGlass
        case strInstructions
        case strDrinkThumb
        case strImageSource
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
        case strMeasure1
        case strMeasure2
        case strMeasure3
        case strMeasure4
        case strMeasure5
        case strMeasure6
        case strMeasure7
        case strMeasure8
        case strMeasure9
        case strMeasure10
        case strMeasure11
        case strMeasure12
        case strMeasure13
        case strMeasure14
        case strMeasure15
        case isFavourite
        case idDrink
    }
    
    
    // MARK: Public methods
    
    func unwrappedFavourite() -> Bool {
        return isFavourite ?? false
    }
}
