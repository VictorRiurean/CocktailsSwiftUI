//
//  Component.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 04/10/2023.
//
//

import Foundation
import SwiftData


@Model public class Component {
    var measure: String = ""
    var name: String = ""
    var cocktail: Cocktail?

    public init() { }
}
