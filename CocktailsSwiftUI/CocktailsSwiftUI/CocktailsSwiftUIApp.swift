//
//  CocktailsSwiftUIApp.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

@main
struct CocktailsSwiftUIApp: App {
    
    // MARK: Environment
    /// Used to detect when app goes to background
    @Environment(\.scenePhase) var scenePhase
    
    
    // MARK: State
    /// We use inject this instance in ContentView at line 25
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
