//
//  CategoryDetailsView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 24/01/2023.
//

import SwiftUI

struct CategoryDetailsView: View {
    
    @State private var drinks: [Drink] = []
    
    private let categoryName: String
    private let viewModel = CategoryDetailsViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                ForEach(drinks) { drink in
                    NavigationLink(destination: CocktailDetailsView(drink: drink)) {
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
    
    init(categoryName: String) {
        self.categoryName = categoryName
    }
}

struct CategoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailsView(categoryName: "Ordinary%20Drink")
    }
}
