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
    
    @State private var image: Image = Image(systemName: "questionmark")
    @State private var name: String = ""
    @State private var category: String = ""
    @State private var glass: String = ""
    @State private var url: String = ""
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
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
            
            Section {
                HStack {
                    Spacer()
                    
                    image
                        .resizable()
                        .frame(width: 150, height: 150)
                        .scaledToFill()
                    
                    Spacer()
                }
            }
            .listRowBackground(Color.clear)
            
            Section(header: Text("Cocktail details")) {
                TextField("Cocktail name", text: $name)
                TextField("Category", text: $category)
                TextField("Glass", text: $glass)
                
                HStack {
                    TextField("URL (optional)", text: $url)
                    
                    Spacer()
                    
                    Button {
                        showingImagePicker = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .disabled(!url.isEmpty)
                }
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
                    cocktail.image = inputImage
                    
                    try? moc.save()
                }
                .disabled(saveButtonEnabled == false)
                
                Spacer()
            }
        }
        .navigationBarBackButtonTitleHidden()
        .navigationTitle("Add Cocktail")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: inputImage) { _ in loadImage() }
        .sheet(isPresented: $showAddIngredient) {
            AddIngredientView(isPresented: $showAddIngredient, components: $ingredients)
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
    }
    
    
    // MARK: Private methods
    
    private func loadImage() {
        guard let inputImage = inputImage else { return }
        
        image = Image(uiImage: inputImage)
    }
}

struct AddFavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        AddFavouriteView()
    }
}
