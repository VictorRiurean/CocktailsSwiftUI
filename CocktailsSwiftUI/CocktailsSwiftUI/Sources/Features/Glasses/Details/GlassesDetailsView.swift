//
//  GlassesDetailsView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 25/01/2023.
//

import SwiftUI

struct GlassesDetailsView: View {
    
    // MARK: State
    
    @State private var drinks: [Drink] = []
    
    
    // MARK: Private properties
    
    private let viewModel = GlassesDetailsViewModel()
    private let glass: String
    
    
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
                await drinks = viewModel.fetchDrinks(glass: glass)
            }
        }
        .navigationTitle(glass)
        .navigationBarTitleDisplayMode(.inline)
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
