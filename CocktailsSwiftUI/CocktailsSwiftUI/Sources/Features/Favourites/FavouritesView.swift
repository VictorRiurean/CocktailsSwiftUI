//
//  FavouritesView.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 26/01/2023.
//

import SwiftUI

struct FavouritesView: View {
    
    @State private var drinks: [Drink] = [
        Drink(strDrink: "Cuba"),
        Drink(strDrink: "Mojito")
    ]
    
    private let viewModel = FavouritesViewModel()
    
    var body: some View {
        NavigationStack {
            
            if drinks.isEmpty {
                Text("Looks like you added no drinks to your favourites list. Please do so by tapping the ❤️")
                    .padding()
                    .navigationTitle("Favourites")
                    .navigationBarTitleDisplayMode(.inline)
            } else {
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
                .navigationTitle("Favourites")
                .navigationBarTitleDisplayMode(.inline)
            }
                
        }
        .onAppear {
            Task {
                // drinks = await viewModel.fetchFavourites()
            }
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
