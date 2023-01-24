//
//  Category.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 19/01/2023.
//

import Foundation

struct Category: Codable, Identifiable {
    let id = UUID()
    var strCategory: String
    
    var urlString: String {
        return strCategory.replacingOccurrences(of: " ", with: "%20")
    }
}

struct Categories: Codable {
    var drinks: [Category]
}

enum DrinkType: String {
    case alcoholic = "Alcoholic"
    case nonAlcoholic = "Non_Alcoholic"
}
