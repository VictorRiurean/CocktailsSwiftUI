//
//  IconicCocktail.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import NukeUI
import SwiftUI

struct IconicCocktail: View {
    
    // MARK: Environment
    
    @Environment(\.colorScheme) var colorScheme
    
    
    // MARK: Private properties
    
    private var drink: Drink
    
    
    // MARK: Body
    
    var body: some View {
        VStack {
            Text(drink.strDrink)
                .font(.headline)
                .minimumScaleFactor(0.5)
                .padding()
            
            Spacer()
            
            if drink.strDrink == "Surprise me!" {
                Image(systemName: "questionmark.circle")
                    .font(.largeTitle)
                    .frame(minWidth: 100, minHeight: 100)
                    .background(Color.teal)
                    .clipShape(Circle())
                    .padding()
            } else {
                LazyImage(url: URL(string: drink.strDrinkThumb!))
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    .padding()
            }
        }
        .frame(maxWidth: 150)
        .frame(height: 200)
        .background(colorScheme == .light ? AppColors.getRandomLightColor(with: drink.strDrink.getFirstCharacterLowercasedOrNil()) : AppColors.getRandomDarkColor(with: drink.strDrink.getFirstCharacterLowercasedOrNil()))
        .cornerRadius(10)
    }
    
    
    // MARK: Lifecycle
    
    init(drink: Drink) {
        self.drink = drink
    }
}

struct IconicCocktail_Previews: PreviewProvider {
    static var previews: some View {
        IconicCocktail(drink: Drink(strDrink: "Test", strCategory: "Category", strAlcoholic: "Yes", strGlass: "Mug"))
    }
}
