//
//  FavouritesView.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 26/01/2023.
//

import SwiftUI

struct FavouritesView: View {
    
    // MARK: Environment
    
    @Environment(\.managedObjectContext) var moc
    
    
    // MARK: FetchRequests
    
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "\(FilterKey.isFavourite.rawValue) \(PredicateFormat.equalsTo.rawValue) \(FilterValue.yes.rawValue)")) var cocktails: FetchedResults<Cocktail>
    
    
    // MARK: Body
    
    var body: some View {
        NavigationStack {
            if cocktails.isEmpty {
                Text("Looks like you added no drinks to your favourites list. Please do so by tapping the ❤️")
                    .padding()
                    .navigationTitle("Favourites")
                    .navigationBarTitleDisplayMode(.inline)
            } else {
                List(cocktails) { cocktail in
                    /// We use the combination of ZStack and empty NavigationLink to hide
                    /// the disclosure chevron that NavigationLinks get by default.
                    ZStack {
                        NavigationLink(destination: CocktailDetailsView(name: cocktail.unwrappedDrink)) { }
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
