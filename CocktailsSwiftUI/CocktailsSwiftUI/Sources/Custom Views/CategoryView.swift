//
//  CategoryView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 19/01/2023.
//

import SwiftUI

struct CategoryView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    private var category: Category
    
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
    
    init(category: Category) {
        self.category = category
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: Category(strCategory: "Palinque"))
    }
}
