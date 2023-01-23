//
//  AssistantView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

struct AssistantView: View {
    var body: some View {
        NavigationView {
            List {
                AssistantCellView(name: "favourite", title: "Favourite Cocktails", description: "Mark cocktails as \"favourites\" so you can have quick access to them.")
                
                AssistantCellView(name: "add", title: "My Cocktails", description: "Didn't find your cocktail in the app? No problem, add it yourself and we will save it for you!")
                
                AssistantCellView(name: "tips", title: "Tips", description: "Take a deep dive into some of the more advanced topics of mixology.")
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
