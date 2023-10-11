//
//  CocktailsSwiftUIApp.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftData
import SwiftUI

@main
struct CocktailsSwiftUIApp: App {
    
    // MARK: Body
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: modelTypes())
    }
    
    
    // MARK: Private methods
    
    private func modelTypes() -> [any PersistentModel.Type] {
        UIImageTransformer.register()
        
        return [Cocktail.self, Component.self]
    }
}
