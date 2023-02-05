//
//  Category.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 19/01/2023.
//

import Foundation

struct Category: Codable, Identifiable {
    
    // MARK: Properties
    
    let id = UUID()
    var strCategory: String
    
    var urlString: String {
        return strCategory.replacingOccurrences(of: " ", with: "%20")
    }
    
    
    // MARK: CodingKeys
    
    enum CodingKeys: CodingKey {
        case id
        case strCategory
    }
}

struct Categories: Codable {
    var drinks: [Category]
}

enum DrinkType: String {
    case alcoholic = "Alcoholic"
    case nonAlcoholic = "Non_Alcoholic"
}
