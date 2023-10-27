//
//  CategoryView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 19/01/2023.
//

import SwiftUI


struct CategoryView: View {
    
    // MARK: Constants
    
    private enum Constants {
        static let textPadding: EdgeInsets = EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
        static let textShadowRadius: CGFloat = 5.0
        static let width: CGFloat = 250.0
        static let cornerRadius: CGFloat = 15.0
    }
    
    
    // MARK: Environment
    
    @Environment(\.colorScheme) var colorScheme
    
    
    // MARK: Private properties
    
    private var category: Category
    private let index: Int
    
    
    // MARK: Body
    
    var body: some View {
        ZStack {
            colorScheme == .light ? AppColors.getLightColorWithIndex(index) : AppColors.getDarkColorWithIndex(index)
            
            Text(category.strCategory)
                .font(.title2)
                .padding(Constants.textPadding)
                .shadow(radius: Constants.textShadowRadius)
        }
        .frame(width: Constants.width)
        .cornerRadius(Constants.cornerRadius)
    }
    
    
    // MARK: Lifecycle
    
    init(category: Category, index: Int) {
        self.category = category
        self.index = index
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: Category(strCategory: "Palinque"), index: 0)
    }
}
