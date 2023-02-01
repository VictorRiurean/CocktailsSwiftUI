//
//  PredicateFormat.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 31/01/2023.
//

import Foundation

enum PredicateFormat: String {
    case beginsWith = "BEGINSWITH[c]"
    case equalsTo = "=="
}

enum FilterKey: String {
    case drinkName = "strDrink"
    case isFavourite
}

enum FilterValue: String {
    case yes = "YES"
    case no = "NO"
}
