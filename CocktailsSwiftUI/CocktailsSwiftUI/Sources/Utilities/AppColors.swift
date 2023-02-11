//
//  AppColors.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 19/01/2023.
//

import UIKit
import SwiftUI

class AppColors {
    
    // MARK: Properties
    
    static var lightColors = [
        Color(UIColor(rgb: 0xf6dfeb)),
        Color(UIColor(rgb: 0xe4bad4)),
        Color(UIColor(rgb: 0xcaf7e3)),
        Color(UIColor(rgb: 0xfceaea)),
        Color(UIColor(rgb: 0xf5d9d9)),
        Color(UIColor(rgb: 0xfbead1)),
        Color(UIColor(rgb: 0xedffec)),
        Color(UIColor(rgb: 0xa6d6d6)),
        Color(UIColor(rgb: 0xededd0))
    ]
    
    static var darkColors = [
        Color(UIColor(rgb: 0x413C69)),
        Color(UIColor(rgb: 0x4A47A3)),
        Color(UIColor(rgb: 0xAD62AA)),
        Color(UIColor(rgb: 0x2C3639)),
        Color(UIColor(rgb: 0x3F4E4F)),
        Color(UIColor(rgb: 0x395B64)),
        Color(UIColor(rgb: 0xA5C9CA)),
        Color(UIColor(rgb: 0xA27B5C)),
        Color(UIColor(rgb: 0xDCD7C9)),
        Color(UIColor(rgb: 0x2C3333)),
        Color(UIColor(rgb: 0xEAB9C9))
    ]
    
    static var lightModeRedButton = Color(UIColor(rgb: 0xEF7B7B))
    static var darkModeRedButton = Color(UIColor(rgb: 0xDA0037))
    static var darkGray = Color(UIColor(rgb: 0x171717))
    
    static let letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    
    
    // MARK: Public methods

    static func getLightColorWithIndex(_ index: Int) -> Color {
        lightColors[index % 9]
    }
    
    static func getRandomLightColor(with letter: String? = nil) -> Color {
        guard letters.contains(letter ?? "") else { return lightColors[0] }
        
        return letter == nil ? lightColors.randomElement()! : lightColors[letters.firstIndex(of: letter!)! % 9]
    }
    
    static func getDarkColorWithIndex(_ index: Int) -> Color {
        darkColors[index % 11]
    }
    
    static func getRandomDarkColor(with letter: String? = nil) -> Color {
        guard letters.contains(letter ?? "") else { return darkColors[0] }
        
        return letter == nil ? darkColors.randomElement()! : darkColors[letters.firstIndex(of: letter!)! % 11]
    }
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

