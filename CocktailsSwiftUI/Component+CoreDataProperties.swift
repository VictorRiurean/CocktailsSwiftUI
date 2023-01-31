//
//  Component+CoreDataProperties.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 31/01/2023.
//
//

import Foundation
import CoreData


extension Component {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Component> {
        return NSFetchRequest<Component>(entityName: "Component")
    }

    @NSManaged public var measure: String?
    @NSManaged public var name: String?
    @NSManaged public var cocktail: Cocktail?
    
    public var unwrappedMeasure: String {
        measure ?? ""
    }
    public var unwrappedName: String {
        name ?? "N/A"
    }

}

extension Component : Identifiable {

}
