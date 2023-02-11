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
    @Environment(\.presentationMode) var presentation
    
    
    // MARK: State
    
    @State private var image: Image = Image(uiImage: UIImage(named: "cocktail")!)
    @State private var name: String = ""
    @State private var category: String = ""
    @State private var glass: String = ""
    @State private var url: String = ""
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var type: String = "Alcoholic"
    @State private var types: [String] = ["Alcoholic", "Non-Alcoholic"]
    @State private var ingredients: [Component] = []
    @State private var ingredientsText: String = ""
    @State private var measureToAdd = ""
    @State private var ingredientToAdd = ""
    @State private var didTouchAddIngredient: Bool = false
    @State private var invalidIngredient: Bool = false
    @State private var instructions: String = ""
    @State private var showNewCocktail: Bool = false
    
    private var saveButtonEnabled: Bool {
        !name.isEmpty && !category.isEmpty && !glass.isEmpty && !ingredients.isEmpty
    }
    private var addIngredientEnabled: Bool {
        !measureToAdd.isEmpty && !ingredientToAdd.isEmpty
    }
    
    
    // MARK: Body
    
    var body: some View {
        ZStack(alignment: .top) {
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
                            .cornerRadius(75)
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
                
                Section(header: SectionHeaderWithTextAndBoolBinding(boolBinding: $didTouchAddIngredient, text: "Ingredients")) {
                    ForEach(ingredients, id: \.self) { ingredient in
                        HStack {
                            Text("\(ingredient.unwrappedMeasure) \(ingredient.unwrappedName)")
                            
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    ingredients.removeAll { $0 == ingredient }
                                }
                            } label: {
                                Image(systemName: "minus")
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                    
                    AddIngredientView(measure: $measureToAdd, name: $ingredientToAdd)
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
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                            
                            showNewCocktail = true
                        }
                    }
                    .disabled(saveButtonEnabled == false)
                    
                    Spacer()
                }
            }
            .navigationBarBackButtonTitleHidden()
            .navigationTitle("Add Cocktail")
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: inputImage) { _ in loadImage() }
            .onChange(of: didTouchAddIngredient) { _ in
                if addIngredientEnabled {
                    let ingredient = Component(context: moc)
                    
                    ingredient.measure = measureToAdd
                    ingredient.name = ingredientToAdd
                    
                    ingredients.append(ingredient)
                    
                    measureToAdd = ""
                    ingredientToAdd = ""
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            invalidIngredient = false
                        }
                    }
                    
                    withAnimation {
                        invalidIngredient = true
                    }
                    
                    UINotificationFeedbackGenerator().notificationOccurred(.error)
                }
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .alert("Cocktail added!", isPresented: $showNewCocktail) {
                Button("OK", role: .cancel) {
                    /// This is how you programmatically dimiss a view
                    presentation.wrappedValue.dismiss()
                }
            }
            
            if invalidIngredient {
                Text("Please make sure measure and ingredient fields aren't empty.")
                    .padding()
                    .background(.white)
                    .clipShape(Capsule())
                    .foregroundColor(.red)
                    .font(.subheadline)
                    .fixedSize(horizontal: false, vertical: true)
                    .transition(.push(from: .top))
            }
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

// MARK: - Custom section header view
/// I was going to move this to its own file but just before doing so
/// I realised that I had never actually used the fileprivate access
/// modifier. At least not intentionally ...
struct SectionHeaderWithTextAndBoolBinding: View {
    
    // MARK: State
    
    @Binding var boolBinding: Bool
    
    
    // MARK: Public properties
    
    fileprivate var text: String
    
    
    // MARK: Body
    
    var body: some View {
        HStack {
            Text(text)
            
            Spacer()
            
            Button {
                boolBinding.toggle()
            } label: {
                Image(systemName: "plus")
            }
        }
    }
}
