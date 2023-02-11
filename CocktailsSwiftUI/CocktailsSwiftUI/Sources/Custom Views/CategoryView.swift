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
    private let index: Int
    
    
    // MARK: Body
    
    var body: some View {
        ZStack {
            colorScheme == .light ? AppColors.getLightColorWithIndex(index) : AppColors.getDarkColorWithIndex(index)
            
            Text(category.strCategory)
                .font(.title2)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                .shadow(radius: 5)
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .cornerRadius(15)
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
