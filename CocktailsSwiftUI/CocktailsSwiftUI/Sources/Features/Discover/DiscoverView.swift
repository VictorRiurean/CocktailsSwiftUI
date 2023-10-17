//
//  DiscoverView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

struct DiscoverView: View {
    
    // MARK: Environment
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) var modelContext
    
    
    // MARK: State
    /// Injected from ContentView via init
    @Binding var tabSelection: Int
    
    @State private var drinks: [CocktailResponse] = []
    
    
    // MARK: Private properties
    
    private let viewModel = DiscoverViewModel()
    
    
    // MARK: Body
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                cocktailCategories
                
                iconicCocktails
            }
            .padding()
            .task {
                if !viewModel.drinksLoaded {
                    await viewModel.fetchCategories()
                    
                    drinks = await viewModel.loadDrinks()
                    
                    drinks.forEach { modelContext.insert(Cocktail(response: $0, modelContext: modelContext)) }
                }
            }
        }
    }
    
    
    // MARK: ViewBuilders
    
    private var cocktailCategories: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Cocktail Categories")
                .font(.title)
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(0 ..< viewModel.categories.count, id: \.self) { index in
                        NavigationLink(destination: CategoryDetailsView(categoryName: viewModel.categories[index].strCategory)) {
                            CategoryView(category: viewModel.categories[index], index: index)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .scrollTargetLayout()
            }
            .frame(height: 150)
            .scrollTargetBehavior(.viewAligned)
            .frame(maxWidth: .infinity)
        }
    }
    
    private var iconicCocktails: some View {
        VStack(alignment: .leading) {
            Text("Iconic cocktails")
                .font(.title)
            
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    Spacer()
                    
                    if drinks.count > 0 {
                        NavigationLink(destination: CocktailDetailsView(name: drinks[0].strDrink)) {
                            IconicCocktail(drink: drinks[0])
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: CocktailDetailsView(name: drinks[1].strDrink)) {
                            IconicCocktail(drink: drinks[1])
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer()
                }
                
                HStack(spacing: 20) {
                    Spacer()
                    
                    if drinks.count > 0 {
                        NavigationLink(destination: CocktailDetailsView(name: drinks[2].strDrink)) {
                            IconicCocktail(drink: drinks[2])
                            
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: CocktailDetailsView(name: drinks[3].strDrink)) {
                            IconicCocktail(drink: drinks[3])
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView(tabSelection: .constant(0))
    }
}
