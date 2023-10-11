//
//  GlassesDetailsView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 25/01/2023.
//

import SwiftData
import SwiftUI


struct GlassesDetailsView: View {
    
    // MARK: FetchRequests
    
    @Query var cocktails: [Cocktail]
    
    
    // MARK: State
    
    @State private var drinks: [CocktailResponse] = []
    
    
    // MARK: Private properties
    
    private let viewModel = GlassesDetailsViewModel()
    private let glass: String
    private var filteredCocktails: [Cocktail] {
        return cocktails.filter { $0.strGlass == glass }
    }
    
    
    // MARK: Body
    
    var body: some View {
        ZStack {
            // MARK: Empty
            if cocktails.isEmpty && drinks.isEmpty {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            
            // MARK: ScrollView
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    if cocktails.isEmpty {
                        ForEach(drinks, id: \.self) { drink in
                            NavigationLink(destination: CocktailDetailsView(name: drink.strDrink)) {
                                DrinkByCategoryView(drink: drink)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    } else {
                        ForEach(filteredCocktails) { cocktail in
                            NavigationLink(destination: CocktailDetailsView(name: cocktail.strDrink)) {
                                DrinkByCategoryView(
                                    drink: CocktailResponse(
                                        strDrink: cocktail.strDrink,
                                        strDrinkThumb: cocktail.strDrinkThumb
                                    )
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
            // MARK: Modifiers
            .navigationBarBackButtonTitleHidden()
            .navigationTitle(glass)
            .navigationBarTitleDisplayMode(.inline)
            // MARK: onAppear
            .onAppear {
                if cocktails.isEmpty {
                    Task {
                        await drinks = viewModel.fetchDrinks(glass: glass)
                    }
                }
            }
        }
    }
    
    // MARK: Lifecycle
    
    init(glass: String) {
        self.glass = glass
    }
}
