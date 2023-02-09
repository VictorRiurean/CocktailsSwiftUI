//
//  Cocktail+CoreDataProperties.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 31/01/2023.
//
//

import Foundation
import CoreData
import UIKit

extension Cocktail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cocktail> {
        return NSFetchRequest<Cocktail>(entityName: "Cocktail")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var idDrink: String?
    @NSManaged public var isFavourite: Bool
    @NSManaged public var strAlcoholic: String?
    @NSManaged public var strCategory: String?
    @NSManaged public var strDrink: String?
    @NSManaged public var strDrinkThumb: String?
    @NSManaged public var strGlass: String?
    @NSManaged public var strImageSource: String?
    @NSManaged public var strInstructions: String?
    @NSManaged public var image: UIImage?
    @NSManaged public var order: Int16
    @NSManaged public var ingredient: NSSet?

    public var unwrappedID: UUID {
        id ?? UUID()
    }
    public var unwrappedIDDrink: String {
        idDrink ?? ""
    }
    public var unwrappedAlcoholic: String {
        strAlcoholic ?? "Alcoholic"
    }
    public var unwrappedCategory: String {
        strCategory ?? "Cocktail"
    }
    public var unwrappedDrink: String {
        strDrink ?? "N/A"
    }
    public var unwrappedThumbnail: String {
        strDrinkThumb ?? ""
    }
    public var unwrappedGlass: String {
        strGlass ?? "Whiskey glass"
    }
    public var unwrappedImageSource: String {
        strImageSource ?? ""
    }
    public var unwrappedInstructions: String {
        strInstructions ?? "N/A"
    }
    public var ingredients: [Component] {
        let set = ingredient as? Set<Component> ?? []
        
        return set.sorted {
            $0.unwrappedName < $1.unwrappedName
        }
    }
    
    public func getIngredientsForCellDescription() -> String {
        var description = ""
        
        if ingredients.count < 4 {
            for index in 0..<ingredients.count {
                description += ingredients[index].unwrappedName.lowercased()
                
                if index < ingredients.count - 1 {
                    description += ", "
                }
            }
        } else {
            for index in 0..<4 {
                description += ingredients[index].unwrappedName.lowercased() + ", "
            }
            
            description += "and more ..."
        }
        
        return description
    }
}

// MARK: Generated accessors for ingredient
extension Cocktail {

    @objc(addIngredientObject:)
    @NSManaged public func addToIngredient(_ value: Component)

    @objc(removeIngredientObject:)
    @NSManaged public func removeFromIngredient(_ value: Component)

    @objc(addIngredient:)
    @NSManaged public func addToIngredient(_ values: NSSet)

    @objc(removeIngredient:)
    @NSManaged public func removeFromIngredient(_ values: NSSet)

}

extension Cocktail : Identifiable {

}
