//
//  ListView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

struct CocktailsView: View {
    
    @State private var drinks: [Drink] = []
    
    private var viewModel = CocktailsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(drinks) { drink in
                    ZStack(alignment: .leading) {
                        NavigationLink(destination: CocktailDetailsView(drink: drink)) {
                            EmptyView()
                        }
                        CocktailCellView(drink: drink)
                    }
                }
            }
            .navigationTitle("Cocktails")
        }
        .onAppear {
            Task {
                drinks = await viewModel.fetchDrinks(startingWith: "a")
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        CocktailsView()
    }
}
