//
//  DrinkByCategoryView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 24/01/2023.
//

import NukeUI
import SwiftUI

struct DrinkByCategoryView: View {
    
    // MARK: Environment
    
    @Environment(\.colorScheme) var colorScheme
    
    
    // MARK: Private properties
    
    private let drink: Drink
    
    
    // MARK: Body
    
    var body: some View {
        VStack {
            Text(drink.strDrink)
                .font(.subheadline)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            
            LazyImage(url: URL(string: drink.strDrinkThumb!))
                .frame(width: 70, height: 70)
                .clipShape(RoundedRectangle(cornerRadius: 35))
                .padding()
        }
        .frame(height: 150)
        .frame(maxWidth: UIScreen.main.bounds.width / 2 - 20)
        .background(colorScheme == .light ? AppColors.getRandomLightColor() : AppColors.getRandomDarkColor())
        .cornerRadius(15)
    }
           
    
    // MARK: Lifecycle
    
    init(drink: Drink) {
        self.drink = drink
    }
}

struct DrinkByCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkByCategoryView(drink: Drink(strDrink: "Cuba"))
    }
}
