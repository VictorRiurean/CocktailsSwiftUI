//
//  Storage.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 01/02/2023.
//

import Foundation
/// We use this because @AppStorage doesn't support arrays yet
/// so we need to use Data() to store string arrays 
class Storage: NSObject {
    static func archiveStringArray(object : [String]) -> Data {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
            return data
        } catch {
            fatalError("Can't encode data: \(error)")
        }
    }
    
    static func loadStringArray(data: Data) -> [String] {
        do {
            guard let array = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String] else {
                return []
            }
            return array
        } catch {
            fatalError("loadWStringArray - Can't encode data: \(error)")
        }
    }    
}
