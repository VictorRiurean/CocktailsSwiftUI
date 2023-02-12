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
        /// The geometryProxy's size attribute returns the size of it's
        /// container view, thus allowing us to give dynamically set
        /// values to the elements inside the HStack
        GeometryReader { geo in
            HStack {
                TextField("Measure", text: $measure)
                    .frame(width: geo.size.width * 0.3)
                
                Divider()
                
                TextField("Ingredient", text: $name)
                    .frame(width: geo.size.width * 0.6)
                    .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 0))
            }
        }
    }
}

struct AddIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        AddIngredientView(measure: .constant(""), name: .constant(""))
    }
}
