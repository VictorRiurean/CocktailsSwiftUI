//
//  DrinkByCategoryView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 24/01/2023.
//

import SwiftUI

struct DrinkByCategoryView: View {
    
    private let drink: Drink
    
    var body: some View {
        VStack {
            Text(drink.strDrink)
                .font(.subheadline)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            
            AsyncImage(url: URL(string: drink.strDrinkThumb ?? "")) { image in
                image.resizable()
            } placeholder: { Color.red }
                .frame(width: 70, height: 70)
                .clipShape(RoundedRectangle(cornerRadius: 35))
                .padding()
        }
        .frame(height: 150)
        .frame(maxWidth: UIScreen.main.bounds.width / 2 - 20)
        .background(AppColors.getRandomColor())
        .cornerRadius(15)
    }
                
    init(drink: Drink) {
        self.drink = drink
    }
}

struct DrinkByCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkByCategoryView(drink: Drink(strDrink: "Cuba"))
    }
}
