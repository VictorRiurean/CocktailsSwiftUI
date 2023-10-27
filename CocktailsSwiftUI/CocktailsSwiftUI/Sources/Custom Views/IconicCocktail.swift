//
//  IconicCocktail.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import NukeUI
import SwiftUI


struct IconicCocktail: View {
    
    // MARK: Constants
    
    private enum Constants {
        static let textMinimumScaleFactor: CGFloat = 0.5
        static let textShadowRadius: CGFloat = 5.0
        static let imageMinWidth: CGFloat = 100.0
        static let imageMinHeight: CGFloat = 100.0
        static let cornerRadius: CGFloat = 10.0
    }
    
    
    // MARK: Environment
    
    @Environment(\.colorScheme) var colorScheme
    
    
    // MARK: Private properties
    
    private var drink: CocktailResponse
    
    
    // MARK: Body
    
    var body: some View {
        VStack {
            Text(drink.strDrink)
                .font(.headline)
                .minimumScaleFactor(Constants.textMinimumScaleFactor)
                .padding()
                .shadow(radius: Constants.textShadowRadius)
            
            Spacer()
            
            LazyImage(url: URL(string: drink.strDrinkThumb!))
                .frame(width: Constants.imageMinWidth, height: Constants.imageMinHeight)
                .clipShape(Circle())
                .padding()
        }
        .frame(maxWidth: .infinity)
        .background(backgroundColor())
        .cornerRadius(Constants.cornerRadius)
    }
    
    
    // MARK: Lifecycle
    
    init(drink: CocktailResponse) {
        self.drink = drink
    }
    
    
    // MARK: Private methods
    
    func backgroundColor() -> Color {
        colorScheme == .light ? AppColors.getRandomLightColor(with: drink.strDrink.getFirstCharacterLowercasedOrNil())
                              : AppColors.getRandomDarkColor(with: drink.strDrink.getFirstCharacterLowercasedOrNil())
    }
}
