//
//  FavouritesViewModel.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 26/01/2023.
//

import SwiftUI

class FavouritesViewModel: ObservableObject {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var cocktails: FetchedResults<Cocktail>
    @FetchRequest(sortDescriptors: []) var ingredients: FetchedResults<Component>
    
    // MARK: Public functions
    
    func fetchFavourites() -> [Drink] {
        return []
    }
}
