//
//  String+FirstCharacter.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 05/02/2023.
//

import Foundation

extension String {
    func getFirstCharacterLowercasedOrNil() -> String? {
        return self.first == nil ? nil : String(self.first!).lowercased()
    }
}
