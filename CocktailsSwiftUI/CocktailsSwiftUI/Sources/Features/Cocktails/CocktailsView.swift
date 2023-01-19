//
//  ListView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

struct CocktailsView: View {
    
    @State private var drinks: [Drink] = [
//        Drink(strDrink: "First", strCategory: "Category I", strAlcoholic: "yes", strGlass: "mug", isFavourite: true),
//        Drink(strDrink: "Second", strCategory: "Category II", strAlcoholic: "no", strGlass: "cup"),
//        Drink(strDrink: "Third", strCategory: "Category IX", strAlcoholic: "yes", strGlass: "cocktail glass")
    ]
    
    private var viewModel = CocktailsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(drinks) { drink in
                    CocktailCellView(drink: drink)
                }
            }
            .navigationTitle("Cocktails")
        }
        .onAppear {
            Task {
                drinks = await viewModel.fetchDrinks()
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        CocktailsView()
    }
}
