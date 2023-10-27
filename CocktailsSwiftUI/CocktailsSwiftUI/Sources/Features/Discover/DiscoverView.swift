//
//  DiscoverView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI


struct DiscoverView: View {
    
    // MARK: Constants
    
    private enum Constants {
        static let containerStackSpacing: CGFloat = 15.0
        static let categoriesStackSpacing: CGFloat = 15.0
        static let categoriesStackHeight: CGFloat = 75.0
        static let iconicStackSpacing: CGFloat = 15.0
        static let iconicStackChildrenSpacing: CGFloat = 15.0
    }
    
    
    // MARK: Environment
    
    @Environment(\.modelContext) var modelContext
    
    
    // MARK: State
    
    @State private var drinks: [CocktailResponse] = []
    
    
    // MARK: Private properties
    
    private let viewModel = DiscoverViewModel()
    
    
    // MARK: Body
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: Constants.containerStackSpacing) {
                cocktailCategories
                
                iconicCocktails
            }
            .navigationTitle("Discover")
            .navigationBarTitleDisplayMode(.large)
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
        VStack(alignment: .leading, spacing: Constants.containerStackSpacing) {
            Text("Cocktail Categories")
                .font(.headline)
            
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
            .frame(height: Constants.categoriesStackHeight)
            .scrollTargetBehavior(.viewAligned)
            .frame(maxWidth: .infinity)
        }
    }
    
    private var iconicCocktails: some View {
        VStack(alignment: .leading, spacing: Constants.iconicStackSpacing) {
            Text("Iconic cocktails")
                .font(.headline)
            
            VStack(spacing: Constants.iconicStackChildrenSpacing) {
                HStack(spacing: Constants.iconicStackChildrenSpacing) {
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
                
                HStack(spacing: Constants.iconicStackChildrenSpacing) {
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
            .frame(maxHeight: .infinity)
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
