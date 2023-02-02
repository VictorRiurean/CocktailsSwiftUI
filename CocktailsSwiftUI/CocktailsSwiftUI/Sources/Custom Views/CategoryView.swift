//
//  CategoryView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 19/01/2023.
//

import SwiftUI

struct CategoryView: View {
    
    // MARK: Environment
    
    @Environment(\.colorScheme) var colorScheme
    
    
    // MARK: Private properties
    
    private var category: Category
    
    
    // MARK: Body
    
    var body: some View {
        ZStack {
            colorScheme == .light ? AppColors.getRandomLightColor() : AppColors.getRandomDarkColor()
            
            Text(category.strCategory)
                .font(.title2)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(colorScheme == .light ? AppColors.getRandomLightColor() : AppColors.getRandomDarkColor())
        .cornerRadius(15)
    }
    
    
    // MARK: Lifecycle
    
    init(category: Category) {
        self.category = category
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: Category(strCategory: "Palinque"))
    }
}
