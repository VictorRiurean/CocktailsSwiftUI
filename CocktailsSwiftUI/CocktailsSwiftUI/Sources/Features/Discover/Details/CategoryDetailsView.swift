//
//  CategoryDetailsView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 24/01/2023.
//

import SwiftUI


struct CategoryDetailsView: View {
    
    // MARK: Constants
    
    private enum Constants {
        static let lazyVGridInsets: EdgeInsets = EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
    }
    
    
    // MARK: State
    
    @State private var drinks: [CocktailResponse] = []
    
    
    // MARK: Private properties
    
    private let categoryName: String
    private let viewModel = CategoryDetailsViewModel()
    
    
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
            .padding(Constants.lazyVGridInsets)
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
