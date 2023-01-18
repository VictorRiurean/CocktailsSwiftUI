//
//  ContentView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = "One"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DiscoverView()
                .tabItem {
                    Label("Discover", systemImage: "binoculars")
                }
            
            CocktailsView()
                .tabItem {
                    Label("Cocktails", systemImage: "wineglass")
                }
            
            IngredientsView()
                .tabItem {
                    Label("Ingredients", systemImage: "list.dash")
                }
            
            GlassesView()
                .tabItem {
                    Label("Glasses", systemImage: "mug")
                }
            
            AssistantView()
                .tabItem {
                    Label("Assistant", systemImage: "person.fill.badge.plus")
                }
        }
    
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
