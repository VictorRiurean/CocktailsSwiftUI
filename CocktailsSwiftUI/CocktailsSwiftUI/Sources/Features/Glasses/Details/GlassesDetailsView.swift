//
//  GlassesDetailsView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 25/01/2023.
//

import SwiftUI

struct GlassesDetailsView: View {
    
    @State private var drinks: [Drink] = []
    
    private let viewModel = GlassesDetailsViewModel()
    private let glass: String
    
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
                await drinks = viewModel.fetchDrinks(glass: glass)
            }
        }
        .navigationTitle(glass)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    init(glass: String) {
        self.glass = glass
    }
}

struct GlassesDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        GlassesDetailsView(glass: "Mug")
    }
}
