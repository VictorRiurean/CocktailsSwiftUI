//
//  CocktailTypeView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 24/01/2023.
//

import SwiftUI

struct CocktailTypeView: View {
    
    @State private var showAlcoholic: Bool
    @State private var drinks: [Drink] = []
    
    private let viewModel = CocktailTypeViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Discover the cocktails in this category")
            
            Picker("What is your favorite color?", selection: $showAlcoholic) {
                Text("Alcoholic").tag(true)
                Text("Non Alcoholic").tag(false)
            }
            .pickerStyle(.segmented)
            .frame(maxWidth: UIScreen.main.bounds.width * 0.75)
            .onChange(of: showAlcoholic) { type in
                Task {
                    drinks = await viewModel.fetchDrinks(with: type ? .alcoholic : .nonAlcoholic)
                }
            }
            
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(drinks) { drink in
                        NavigationLink(destination: CocktailDetailsView(name: drink.strDrink)) {
                            DrinkByCategoryView(drink: drink)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
    
            Spacer()
        }
        .navigationBarBackButtonTitleHidden()
        .navigationTitle(showAlcoholic ? "Alcoholic" : "Non Alcoholic")
        .onAppear {
            Task {
                drinks = await viewModel.fetchDrinks(with: showAlcoholic ? .alcoholic : .nonAlcoholic)
            }
        }
    }
    
    init(showAlcoholic: Bool) {
        self.showAlcoholic = showAlcoholic
    }
}

struct CocktailTypeView_Previews: PreviewProvider {
    static var previews: some View {
        CocktailTypeView(showAlcoholic: true)
    }
}
