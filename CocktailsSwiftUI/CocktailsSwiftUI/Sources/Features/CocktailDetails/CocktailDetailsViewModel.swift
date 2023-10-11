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
    
    func fetchDrink(name: String) async -> CocktailResponse {
        await service.fetchDrink(with: name)
    }
    
    func addDrinksToCoreData(drinks: [CocktailResponse], context: NSManagedObjectContext) {
        databaseManager.addDrinksToCoreData(drinks: drinks, context: context)
    }
}
