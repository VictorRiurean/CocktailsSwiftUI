//
//  GlassesDetailsView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 25/01/2023.
//

import SwiftUI

struct GlassesDetailsView: View {
    
    // MARK: FetchRequests
    
    @FetchRequest(sortDescriptors: []) var cocktails: FetchedResults<Cocktail>
    
    
    // MARK: State
    
    @State private var drinks: [Drink] = []
    
    
    // MARK: Private properties
    
    private let viewModel = GlassesDetailsViewModel()
    private let glass: String
    private var filteredCocktails: [Cocktail] {
        return cocktails.filter { $0.strGlass == glass }
    }
    
    // MARK: Body
    
    var body: some View {
        ZStack {
            if cocktails.isEmpty && drinks.isEmpty {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    if cocktails.isEmpty {
                        ForEach(drinks) { drink in
                            NavigationLink(destination: CocktailDetailsView(name: drink.strDrink)) {
                                DrinkByCategoryView(drink: drink)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    } else {
                        ForEach(filteredCocktails) { cocktail in
                            NavigationLink(destination: CocktailDetailsView(name: cocktail.unwrappedDrink)) {
                                DrinkByCategoryView(drink: Drink(strDrink: cocktail.unwrappedDrink, strDrinkThumb: cocktail.unwrappedThumbnail))
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
            .navigationBarBackButtonTitleHidden()
            .onAppear {
                if cocktails.isEmpty {
                    Task {
                        await drinks = viewModel.fetchDrinks(glass: glass)
                    }
                }
            }
            .navigationTitle(glass)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: Lifecycle
    
    init(glass: String) {
        self.glass = glass
    }
}

struct GlassesDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        GlassesDetailsView(glass: "Mug")
    }
}
