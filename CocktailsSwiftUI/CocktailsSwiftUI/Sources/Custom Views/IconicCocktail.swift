//
//  IconicCocktail.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

struct IconicCocktail: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    private var drink: Drink
    
    var body: some View {
        VStack {
            Text(drink.strDrink)
                .font(.headline)
                .minimumScaleFactor(0.5)
                .padding()
            
            Spacer()
            
            if drink.strDrink == "Surprize me!" {
                Image(systemName: "questionmark.circle")
                    .font(.largeTitle)
                    .frame(minWidth: 100, minHeight: 100)
                    .background(Color.teal)
                    .clipShape(Circle())
                    .padding()
            } else {
                AsyncImage(url: URL(string: drink.strDrinkThumb ?? "")) { image in
                    image.resizable()
                } placeholder: { Color.red }
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    .padding()
            }
        }
        .frame(maxWidth: 150)
        .frame(height: 200)
        .background(colorScheme == .light ? AppColors.getRandomLightColor() : AppColors.getRandomDarkColor())
        .cornerRadius(10)
    }
    
    init(drink: Drink) {
        self.drink = drink
    }
}

struct IconicCocktail_Previews: PreviewProvider {
    static var previews: some View {
        IconicCocktail(drink: Drink(strDrink: "Test", strCategory: "Category", strAlcoholic: "Yes", strGlass: "Mug"))
    }
}
