//
//  CocktailCellView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 19/01/2023.
//

import SwiftUI

struct CocktailCellView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    private var drink: Drink
    @State private var ingredients: String = ""
    
    var body: some View {
        HStack {
            
            if drink.strDrinkThumb != nil {
                AsyncImage(url: URL(string: drink.strDrinkThumb!)) { image in
                    image.resizable()
                } placeholder: { Color.red }
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 35))
                    .padding()
            } else {
                Image(systemName: "questionmark.app.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 35))
                    .padding()
                    .foregroundColor(colorScheme == .light ? AppColors.getRandomLightColor() : AppColors.getRandomDarkColor())
                    
            }
            
            
            VStack(alignment: .leading) {
                Text(drink.strDrink)
                    .font(.headline)
                
                Spacer()
                
                Text(ingredients)
                    .font(.subheadline)
                    .lineLimit(3)
                    .minimumScaleFactor(0.5)
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            
            Spacer()
            
            Image(systemName: drink.unwrappedFavourite() ? "heart.fill" : "heart")
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(colorScheme == .light ? AppColors.getRandomLightColor() : AppColors.getRandomDarkColor())
        .cornerRadius(15)
        .onAppear {
            ingredients = getIngredients()
        }
    }
    
    init(drink: Drink) {
        self.drink = drink
    }
    
    func getIngredients() -> String {
        var text = ""
        
        if let ingredient1 = drink.strIngredient1 {
            text += ingredient1
            if let ingredient2 = drink.strIngredient2 {
                text += ", " + ingredient2
                if let ingredient3 = drink.strIngredient3 {
                    text += ", " + ingredient3
                    if let _ = drink.strIngredient4 {
                        text += " and more!"
                    }
                }
            }
        }
        
        return text
    }
}

struct CocktailCellView_Previews: PreviewProvider {
    static var previews: some View {
        CocktailCellView(drink: Drink(strDrink: "Test drink", strCategory: "Test category", strAlcoholic: "Yes", strGlass: "Big glass"))
    }
}
