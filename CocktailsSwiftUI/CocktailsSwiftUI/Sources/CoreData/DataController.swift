//
//  DataController.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 30/01/2023.
//

import CoreData

class DataController: ObservableObject {
    
    // A test configuration for SwiftUI previews
    static var preview: DataController = {
        let controller = DataController()

        // Create 10 cocktails
        for i in 0..<10 {
            let cocktail = Cocktail(context: controller.container.viewContext)
            
            cocktail.strDrink = "Cocktail \(i)"
            cocktail.strInstructions = "This is just a test cocktail, you don't prepare it."
            cocktail.isFavourite = i % 2 == 0
        }

        return controller
    }()
    
    let container = NSPersistentContainer(name: "Model")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
