//
//  CocktailType.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

struct CocktailType: View {
    var body: some View {
        ZStack {
            Color.purple
                .ignoresSafeArea()
            
            Text("Alcoholic")
                .font(.headline)
                .foregroundColor(.white)
        }
        .cornerRadius(10)
        .padding()
    }
}

struct CocktailType_Previews: PreviewProvider {
    static var previews: some View {
        CocktailType()
    }
}
