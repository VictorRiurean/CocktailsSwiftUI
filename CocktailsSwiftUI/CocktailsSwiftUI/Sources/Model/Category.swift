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
}

struct Categories: Codable {
    var drinks: [Category]
}
