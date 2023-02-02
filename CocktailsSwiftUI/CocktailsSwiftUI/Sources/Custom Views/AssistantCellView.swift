//
//  AssistantCellView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 23/01/2023.
//

import SwiftUI

struct AssistantCellView: View {
    
    // MARK: Private properties
    
    private let name: String
    private let title: String
    private let description: String
    
    
    // MARK: Body
    
    var body: some View {
        HStack {
            Image(name)
                /// Without this modifier images are rendered at original size
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
    
    
    // MARK: Lifecycle
    
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
