//
//  CocktailDetailsView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 24/01/2023.
//

import SwiftUI

struct CocktailDetailsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var drink: Drink
    @State private var ingredientsAndMeasures: [IngredientAndMeasure] = []
    
    private let viewModel = CocktailDetailsViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    AsyncImage(url: URL(string: drink.strDrinkThumb ?? "")) { image in
                        image.resizable()
                    } placeholder: { Image(systemName: "placeholdertext.fill").resizable() }
                        .frame(width: 150, height: 150)
                        .padding()
                    
                    Text((drink.strCategory ?? "") + " | " + (drink.strAlcoholic ?? ""))
                        .font(.title)
                    
                    Text("Served in: " + (drink.strGlass ?? ""))
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
                            .background(colorScheme == .light ? AppColors.getRandomLightColor() : AppColors.getRandomDarkColor())
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                VStack {
                    Text("Preparation")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    
                    Text(drink.strInstructions ?? "")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(colorScheme == .light ? AppColors.getRandomLightColor() : AppColors.getRandomDarkColor())
                        .lineLimit(nil)
                        .cornerRadius(10)
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle(drink.strDrink)
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationBarBackButtonTitleHidden()
        .onAppear {
            Task {
                if drink.strCategory == nil {
                    await drink = viewModel.fetchDrink(name: drink.strDrink)
                }
                
                ingredientsAndMeasures = drink.ingredientsAndMesaures
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
    
    init(drink: Drink) {
        _drink = State(initialValue: drink)
    }
}

struct CocktailDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CocktailDetailsView(drink: Drink(strDrink: "Cuba"))
    }
}
