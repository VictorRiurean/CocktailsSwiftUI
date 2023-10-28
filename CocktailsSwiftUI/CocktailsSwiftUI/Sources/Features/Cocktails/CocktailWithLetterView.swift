//
//  CocktailWithLetterView.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 28/10/2023.
//

import SwiftUI


struct CocktailWithLetterView: View {
    
    // MARK: Constants
    
    private enum Constants {
        static let insets: EdgeInsets = EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
    }
    
    // MARK: State
    
    @Binding var drinkName: String
    @Binding var isShowingRandomCocktail: Bool
    
    
    // MARK: Public properties
    
    let cocktails: [Cocktail]
    let letter: String
    
    
    // MARK: Body
    
    var body: some View {
        ForEach(cocktail(with: letter)) { cocktail in
            /// This was the only navigation that was working properly with LazyVStack.
            /// Also, swipeAction and onDelete don't work properly with LazyVStacks.
            CocktailCellView(drinkName: cocktail.strDrink, letter: letter)
                .padding(Constants.insets)
                .onTapGesture {
                    drinkName = cocktail.strDrink
                    isShowingRandomCocktail = true
                }
                .navigationDestination(isPresented: $isShowingRandomCocktail) {
                    CocktailDetailsView(name: drinkName)
                }
        }
    }
    
    
    // MARK: Private methods
    
    private func cocktail(with letter: String) -> [Cocktail] {
        cocktails.filter { $0.strDrink.lowercased().starts(with: letter) }
    }
}
