//
//  Glass.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 23/01/2023.
//

import Foundation

struct Glass: Codable, Identifiable {
    
    // MARK: Properties
    
    let id: UUID = UUID()
    var strGlass: String
    
    
    // MARK: CodingKeys
    
    enum CodingKeys: CodingKey {
        case id
        case strGlass
    }
}

struct Glasses: Codable {
    var drinks: [Glass]
}
