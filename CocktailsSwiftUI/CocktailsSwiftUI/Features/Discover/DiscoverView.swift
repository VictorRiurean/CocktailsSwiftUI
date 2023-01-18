//
//  DiscoverView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

struct DiscoverView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Cocktail Categories")
                .font(.title)
            
            ScrollView(.horizontal) {
                LazyHStack {
                    RoundedRectangle(cornerRadius: 25, style: .circular)
                                    .fill(.red)
                                    .frame(width: 200, height: 150)
                    RoundedRectangle(cornerRadius: 25, style: .circular)
                                    .fill(.red)
                                    .frame(width: 200, height: 150)
                    RoundedRectangle(cornerRadius: 25, style: .circular)
                                    .fill(.red)
                                    .frame(width: 200, height: 150)
                    RoundedRectangle(cornerRadius: 25, style: .circular)
                                    .fill(.red)
                                    .frame(width: 200, height: 150)
                }
            }
            
            Text("Iconic cocktails")
                .font(.title)
            
            HStack {
                IconicCocktail()
                IconicCocktail()
            }
            
            HStack {
                IconicCocktail()
                IconicCocktail()
            }
            
            HStack {
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Show more")
                        .padding()
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .background(Color.red)
                .contentShape(Rectangle())
                .cornerRadius(10)
                
                
                Spacer()
            }
            
            HStack(spacing: 10) {
                CocktailType()
                CocktailType()
            }
            
            Spacer()
        }
        .padding()
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
