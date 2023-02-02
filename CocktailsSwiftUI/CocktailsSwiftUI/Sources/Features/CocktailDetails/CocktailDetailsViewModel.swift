//
//  CocktailDetailsViewModel.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 24/01/2023.
//

import CoreData
import SwiftUI

struct CocktailDetailsViewModel {
    
    // MARK: Private properties
    
    private let service = WebService.shared
    private let databaseManager = DatabaseManager.shared
    
    
    // MARK: Public methods
    
    func fetchDrink(name: String) async -> Drink {
        await service.fetchDrink(with: name)
    }
    
    func addDrinksToCoreData(drinks: [Drink], context: NSManagedObjectContext) {
        databaseManager.addDrinksToCoreData(drinks: drinks, context: context)
    }
}
