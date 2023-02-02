//
//  IngredientsDetailsView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 25/01/2023.
//

import SwiftUI

struct IngredientsDetailsView: View {
    
    // MARK: State
    
    @State private var drinks: [Drink] = []
    
    
    // MARK: Private properties

    private let viewModel = IngredientsDetailsViewModel()
    private let ingredient: String

    
    // MARK: Body
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                ForEach(drinks) { drink in
                    NavigationLink(destination: CocktailDetailsView(name: drink.strDrink)) {
                        DrinkByCategoryView(drink: drink)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .navigationBarBackButtonTitleHidden()
        .onAppear {
            Task {
                await drinks = viewModel.fetchDrinks(ingredient: ingredient)
            }
        }
        .navigationTitle(ingredient)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    // MARK: Lifecycle
    
    init(ingredient: String) {
        self.ingredient = ingredient
    }
}

struct IngredientsDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsDetailsView(ingredient: "Rum")
    }
}
