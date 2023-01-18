//
//  IconicCocktail.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

struct IconicCocktail: View {
    var body: some View {
        VStack {
            Text("Tap me")
                .padding()
            
            Image(systemName: "homepodmini")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .padding()
        }
        .background(Color.teal)
        .cornerRadius(10)
        .padding()
    }
}

struct IconicCocktail_Previews: PreviewProvider {
    static var previews: some View {
        IconicCocktail()
    }
}
