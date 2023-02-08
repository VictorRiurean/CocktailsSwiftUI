//
//  AddIngredientView.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 07/02/2023.
//

import SwiftUI

struct AddIngredientView: View {
    
    // MARK: Environment
    
    @Environment(\.managedObjectContext) var moc

    
    // MARK: State
    
    @Binding var isPresented: Bool
    @Binding var components: [Component]
    
    @State private var measure = ""
    @State private var name = ""
    
    private var saveButtonActive: Bool {
        !measure.isEmpty && !name.isEmpty
    }
    
    var body: some View {
        Form {
            TextField("Measure", text: $measure)
            TextField("Name", text: $name)
            
            HStack(spacing: 50) {
                Spacer()
                
                Button("Save") {
                    let ingredient = Component(context: moc)
                    
                    ingredient.name = name
                    ingredient.measure = measure
                    
                    components.append(ingredient)
                    
                    isPresented = false
                }
                .disabled(!saveButtonActive)
                
                Button("Cancel") {
                    isPresented = false
                }
                
                Spacer()
            }
        }
        .navigationTitle("Add ingredient")
        .navigationBarTitleDisplayMode(.inline)
    }
}
