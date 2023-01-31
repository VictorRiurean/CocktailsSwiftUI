//
//  FavouritesView.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 26/01/2023.
//

import SwiftUI

struct FavouritesView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var cocktails: FetchedResults<Cocktail>
    @FetchRequest(sortDescriptors: []) var ingredients: FetchedResults<Component>
    
    
    @State private var drinks: [Drink] = [
        Drink(strDrink: "Cuba"),
        Drink(strDrink: "Mojito")
    ]
    
    @ObservedObject var viewModel = FavouritesViewModel()
    
    var body: some View {
        NavigationStack {
            
            if drinks.isEmpty {
                Text("Looks like you added no drinks to your favourites list. Please do so by tapping the ❤️")
                    .padding()
                    .navigationTitle("Favourites")
                    .navigationBarTitleDisplayMode(.inline)
            } else {
                List {
                    ForEach(cocktails) { drink in
                        ZStack(alignment: .leading) {
//                            NavigationLink(destination: CocktailDetailsView(drink: drink)) {
//                                EmptyView()
//                            }
                            CocktailCellView(drink: Drink(strDrink: drink.unwrappedDrink, strDrinkThumb: drink.unwrappedThumbnail))
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
