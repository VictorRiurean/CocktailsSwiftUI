//
//  UIImageTransformer.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 08/02/2023.
//

import UIKit

class UIImageTransformer: ValueTransformer {
    
    static let name = NSValueTransformerName(rawValue: "UIImageTransformer")
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let image = value as? UIImage else { return nil }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: image, requiringSecureCoding: true)
            print("data: \(data)")
            return data
        } catch {
            print("Failed to data")
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        
        do {
            let image = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIImage.self, from: data)
            print("reverse: \(image)")
            return image
        } catch {
            print("failed to reverse")
            return nil
        }
    }
    
    static func register() {
        ValueTransformer.setValueTransformer(UIImageTransformer(), forName: name)
    }
}
