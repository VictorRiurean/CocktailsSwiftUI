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
        ZStack {
            if drinks.isEmpty {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(drinks) { drink in
                        NavigationLink(destination: CocktailDetailsView(name: drink.strDrink)) {
                            DrinkByCategoryView(drink: drink)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
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
