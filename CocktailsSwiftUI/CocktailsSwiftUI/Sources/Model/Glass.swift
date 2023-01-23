//
//  Glass.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 23/01/2023.
//

import Foundation

struct Glass: Codable, Identifiable {
    let id: UUID = UUID()
    var strGlass: String
}

struct Glasses: Codable {
    var drinks: [Glass]
}
