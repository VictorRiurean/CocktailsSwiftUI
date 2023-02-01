//
//  CocktailsSwiftUIApp.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

@main
struct CocktailsSwiftUIApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            try? dataController.container.viewContext.save()
        }
    }
}
