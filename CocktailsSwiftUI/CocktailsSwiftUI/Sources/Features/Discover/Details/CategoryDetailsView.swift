//
//  CategoryDetailsView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 24/01/2023.
//

import SwiftUI

struct CategoryDetailsView: View {
    
    // MARK: State
    
    @State private var drinks: [Drink] = []
    
    
    // MARK: Private properties
    
    private let categoryName: String
    private let viewModel = CategoryDetailsViewModel()
    
    
    // MARK: Body
    
    var body: some View {
        ScrollView(.vertical) {
            /// This is how you make a two column grid
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
                await drinks = viewModel.fetchDrinks(category: categoryName)
            }
        }
        .navigationTitle(categoryName)
    }
    
    
    // MARK: Lifecycle
    
    init(categoryName: String) {
        self.categoryName = categoryName
    }
}

struct CategoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailsView(categoryName: "Ordinary%20Drink")
    }
}
