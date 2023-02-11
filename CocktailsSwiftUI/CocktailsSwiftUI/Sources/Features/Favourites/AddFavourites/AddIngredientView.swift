//
//  AddIngredientView.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 07/02/2023.
//

import SwiftUI

struct AddIngredientView: View {
    
    // MARK: State
    
    @Binding var measure: String
    @Binding var name: String
    
    
    // MARK: Body
    
    var body: some View {
        HStack {
            TextField("Measure", text: $measure)
            
            Divider()
            
            TextField("Ingredient", text: $name)
        }
    }
}
