//
//  ContentView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Environment
    
    @Environment(\.colorScheme) var colorScheme
    
    
    // MARK: State
    /// This is passed as a binding via DiscoverView's init in order
    /// to be able to programmatically change tabs at line 106
    @State private var selectedTab = 0
    
    
    // MARK:  Body
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DiscoverView(tabSelection: $selectedTab)
                .tabItem {
                    Label("Discover", systemImage: "binoculars")
                }
                .tag(0)
            
            CocktailsView()
                .tabItem {
                    Label("Cocktails", systemImage: "wineglass")
                }
                .tag(1)
            
            IngredientsView()
                .tabItem {
                    Label("Ingredients", systemImage: "list.dash")
                }
                .tag(2)
            
            GlassesView()
                .tabItem {
                    Label("Glasses", systemImage: "mug")
                }
                .tag(3)
            
            AssistantView()
                .tabItem {
                    Label("Assistant", systemImage: "person.fill.badge.plus")
                }
                .tag(4)
        }
        /// Sets tintColor for tabView
        .accentColor(colorScheme == .light ? AppColors.darkGray : .orange)
        /// This prevents tabView background from glitching when something is pushed on the
        /// navigationStack and the initial view has a scroll with content underneath it
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            
            tabBarAppearance.configureWithDefaultBackground()
            
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
