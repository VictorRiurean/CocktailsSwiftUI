//
//  CocktailDetailsView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 24/01/2023.
//

import SwiftUI

struct CocktailDetailsView: View {
    
    @State private var drink: Drink?
    @State private var ingredientsAndMeasures: [IngredientAndMeasure] = []
    private let drinkName: String
    private let viewModel = CocktailDetailsViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    AsyncImage(url: URL(string: drink?.strDrinkThumb ?? "")) { image in
                        image.resizable()
                    } placeholder: { Image(systemName: "placeholdertext.fill").resizable() }
                        .frame(width: 150, height: 150)
                        .padding()
                    
                    Text((drink?.strCategory ?? "") + " | " + (drink?.strAlcoholic ?? ""))
                        .font(.title)
                    
                    Text("Served in:" + (drink?.strGlass ?? ""))
                        .font(.title3)
                    
                    Divider()
                }
                .padding()
                
                VStack {
                    Text("Ingredients")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    
                    ForEach(ingredientsAndMeasures, id: \.self) {
                        Text("\($0.measure) \($0.ingredient)")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(AppColors.getRandomColor())
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                VStack {
                    Text("Preparation")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    
                    Text(drink?.strInstructions ?? "")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(AppColors.getRandomColor())
                        .lineLimit(nil)
                        .cornerRadius(10)
                }
                .padding()
                
                Spacer()
            }
            .navigationBarTitle(drink?.strDrink ?? "")
        }
        .onAppear {
            Task {
                await drink = viewModel.fetchDrink(name: drinkName)
                
                getIngredientsAndMeasures()
            }
        }
        .toolbar {
            Button {
                print("Edit button was tapped")
            } label: {
                Image(systemName: "heart")
            }
            
            Button {
                print("Edit button was tapped")
            } label: {
                Image(systemName: "square.and.arrow.up")
            }
        }
    }
    
    init(drinkName: String) {
        self.drinkName = drinkName
    }
    
    func getIngredientsAndMeasures() {
        if let ingredient = drink?.strIngredient1 {
            ingredientsAndMeasures.append(IngredientAndMeasure(ingredient: ingredient, measure: drink?.strMeasure1 ?? ""))
        }
        if let ingredient = drink?.strIngredient2 {
            ingredientsAndMeasures.append(IngredientAndMeasure(ingredient: ingredient, measure: drink?.strMeasure2 ?? ""))
        }
        if let ingredient = drink?.strIngredient3 {
            ingredientsAndMeasures.append(IngredientAndMeasure(ingredient: ingredient, measure: drink?.strMeasure3 ?? ""))
        }
        if let ingredient = drink?.strIngredient4 {
            ingredientsAndMeasures.append(IngredientAndMeasure(ingredient: ingredient, measure: drink?.strMeasure4 ?? ""))
        }
        if let ingredient = drink?.strIngredient5 {
            ingredientsAndMeasures.append(IngredientAndMeasure(ingredient: ingredient, measure: drink?.strMeasure5 ?? ""))
        }
        if let ingredient = drink?.strIngredient6 {
            ingredientsAndMeasures.append(IngredientAndMeasure(ingredient: ingredient, measure: drink?.strMeasure6 ?? ""))
        }
        if let ingredient = drink?.strIngredient7 {
            ingredientsAndMeasures.append(IngredientAndMeasure(ingredient: ingredient, measure: drink?.strMeasure7 ?? ""))
        }
        if let ingredient = drink?.strIngredient8 {
            ingredientsAndMeasures.append(IngredientAndMeasure(ingredient: ingredient, measure: drink?.strMeasure8 ?? ""))
        }
        if let ingredient = drink?.strIngredient9 {
            ingredientsAndMeasures.append(IngredientAndMeasure(ingredient: ingredient, measure: drink?.strMeasure9 ?? ""))
        }
        if let ingredient = drink?.strIngredient10 {
            ingredientsAndMeasures.append(IngredientAndMeasure(ingredient: ingredient, measure: drink?.strMeasure10 ?? ""))
        }
        if let ingredient = drink?.strIngredient11 {
            ingredientsAndMeasures.append(IngredientAndMeasure(ingredient: ingredient, measure: drink?.strMeasure11 ?? ""))
        }
        if let ingredient = drink?.strIngredient12 {
            ingredientsAndMeasures.append(IngredientAndMeasure(ingredient: ingredient, measure: drink?.strMeasure12 ?? ""))
        }
        if let ingredient = drink?.strIngredient13 {
            ingredientsAndMeasures.append(IngredientAndMeasure(ingredient: ingredient, measure: drink?.strMeasure13 ?? ""))
        }
        if let ingredient = drink?.strIngredient14 {
            ingredientsAndMeasures.append(IngredientAndMeasure(ingredient: ingredient, measure: drink?.strMeasure14 ?? ""))
        }
        if let ingredient = drink?.strIngredient15 {
            ingredientsAndMeasures.append(IngredientAndMeasure(ingredient: ingredient, measure: drink?.strMeasure15 ?? ""))
        }
    }
}

struct CocktailDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CocktailDetailsView(drinkName: "Cuba")
    }
}
