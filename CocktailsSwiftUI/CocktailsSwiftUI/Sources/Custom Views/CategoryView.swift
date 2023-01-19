//
//  CategoryView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 19/01/2023.
//

import SwiftUI

struct CategoryView: View {
    
    private var category: Category
    
    var body: some View {
        ZStack {
            AppColors.getRandomColor()
            
            Text(category.strCategory)
                .font(.title2)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(AppColors.getRandomColor())
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
