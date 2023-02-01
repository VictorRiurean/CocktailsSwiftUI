//
//  FavouritesView.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 26/01/2023.
//

import SwiftUI

struct FavouritesView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "\(FilterKey.isFavourite.rawValue) \(PredicateFormat.equalsTo.rawValue) \(FilterValue.yes.rawValue)")) var cocktails: FetchedResults<Cocktail>
    
    @ObservedObject var viewModel = FavouritesViewModel()
    
    var body: some View {
        NavigationStack {
            if cocktails.isEmpty {
                Text("Looks like you added no drinks to your favourites list. Please do so by tapping the ❤️")
                    .padding()
                    .navigationTitle("Favourites")
                    .navigationBarTitleDisplayMode(.inline)
            } else {
                List(cocktails) { cocktail in
                    ZStack {
                        NavigationLink(destination: CocktailDetailsView(drink: Drink(strDrink: cocktail.unwrappedDrink, strDrinkThumb: cocktail.unwrappedThumbnail))) { }
                            .opacity(0)
                        
                        CocktailCellView(drinkName: cocktail.unwrappedDrink)
                            .buttonStyle(PlainButtonStyle())
                    }
                    
                }
                .navigationTitle("Favourites")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .navigationBarBackButtonTitleHidden()
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
