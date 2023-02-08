//
//  AddFavouriteView.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 07/02/2023.
//

import SwiftUI

struct AddFavouriteView: View {
    
    // MARK: Environment
    
    @Environment(\.managedObjectContext) var moc
    
    
    // MARK: State
    
    @State private var name: String = ""
    @State private var category: String = ""
    @State private var glass: String = ""
    @State private var url: String = ""
    @State private var type: String = "Alcoholic"
    @State private var types: [String] = ["Alcoholic", "Non-Alcoholic"]
    @State private var ingredients: [Component] = []
    @State private var showAddIngredient: Bool = false
    @State private var instructions: String = ""
    
    private var saveButtonEnabled: Bool {
        !name.isEmpty && !category.isEmpty && !glass.isEmpty && !ingredients.isEmpty
    }
    
    var body: some View {
        Form {
            Picker("Choose cocktail type", selection: $type) {
                ForEach(types, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            
            Section(header: Text("Cocktail details")) {
                TextField("Cocktail name", text: $name)
                TextField("Category", text: $category)
                TextField("Glass", text: $glass)
                TextField("URL (optional)", text: $url)
            }
            
            Section(header: Text("Ingredients")) {
                
                ForEach(ingredients, id: \.self) { ingredient in
                    HStack {
                        Text("\(ingredient.unwrappedMeasure) \(ingredient.unwrappedName)")
                        
                        Spacer()
                        
                        Button {
                            ingredients.removeAll { $0 == ingredient }
                        } label: {
                            Image(systemName: "minus")
                        }
                    }
                }
                
                HStack {
                    Spacer()
                    
                    Button {
                        showAddIngredient = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            
            Section(header: Text("Preparation")) {
                TextField("Instructions", text: $instructions)
            }
            
            HStack {
                Spacer()
                
                Button("Save") {
                    let cocktail = Cocktail(context: moc)
                    
                    cocktail.id = UUID()
                    cocktail.strDrink = name
                    cocktail.strCategory = category
                    cocktail.strAlcoholic = type
                    cocktail.strInstructions = instructions
                    cocktail.ingredient = NSSet(array: ingredients)
                    cocktail.isFavourite = true
                    
                    try? moc.save()
                }
                .disabled(saveButtonEnabled == false)
                
                Spacer()
            }
        }
        .navigationBarBackButtonTitleHidden()
        .navigationTitle("Add Cocktail")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showAddIngredient) {
            AddIngredientView(isPresented: $showAddIngredient, components: $ingredients)
        }
    }
}
