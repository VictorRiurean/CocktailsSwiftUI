//
//  Ingredient.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 23/01/2023.
//

import Foundation

struct Ingredient: Codable, Identifiable {
    
    // MARK: Properties
    
    let id: UUID = UUID()
    var strIngredient1: String
    
    var urlString: String {
        return strIngredient1.replacingOccurrences(of: " ", with: "%20")
    }
    
    
    // MARK: CodingKeys
    
    enum CodingKeys: CodingKey {
        case id
        case strIngredient1
    }
}

struct Ingredients: Codable {
    var drinks: [Ingredient]
}
