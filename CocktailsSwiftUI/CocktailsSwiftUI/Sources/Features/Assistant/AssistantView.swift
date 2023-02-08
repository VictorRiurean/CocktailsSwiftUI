//
//  AssistantView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

struct AssistantView: View {
    
    // MARK: Body
    
    var body: some View {
        NavigationStack {
            List {
                ZStack(alignment: .leading)  {
                    NavigationLink(destination: FavouritesView()) { }
                        .opacity(0)
                    
                    AssistantCellView(name: "favourite", title: "Favourite Cocktails", description: "Mark cocktails as \"favourites\" so you can have quick access to them.")
                }
                
                ZStack(alignment: .leading) {
                    NavigationLink(destination: AddFavouriteView()) { }
                        .opacity(0)
                    
                    AssistantCellView(name: "add", title: "My Cocktails", description: "Didn't find your cocktail in the app? No problem, add it yourself and we will save it for you!")
                }
                
                ZStack(alignment: .leading) {
                    NavigationLink(destination: TipsView()) { }
                        .opacity(0)
                    
                    AssistantCellView(name: "tips", title: "Tips", description: "Take a deep dive into some of the more advanced topics of mixology.")
                }
            }
            .navigationTitle("Assistant")
        }
    }
}

struct AssistantView_Previews: PreviewProvider {
    static var previews: some View {
        AssistantView()
    }
}
