//
//  AssistantCellView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 23/01/2023.
//

import SwiftUI

struct AssistantCellView: View {
    
    private let name: String
    private let title: String
    private let description: String
    
    var body: some View {
        HStack {
            Image(name)
                .resizable()
                .frame(width: 75, height: 75)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title)
                
                Text(description)
                    .font(.caption)
            }
        }
    }
    
    init(name: String, title: String, description: String) {
        self.name = name
        self.title = title
        self.description = description
    }
}

struct AssistantCellView_Previews: PreviewProvider {
    static var previews: some View {
        AssistantCellView(name: "add", title: "Favourite Cocktails", description: "Mark cocktails as \"favourites\" so you can have quick access to them.")
    }
}
