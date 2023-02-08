//
//  CocktailTypeView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 24/01/2023.
//

import SwiftUI

struct CocktailTypeView: View {
    
    // MARK: FetchRequests
    
    @FetchRequest(sortDescriptors: []) var cocktails: FetchedResults<Cocktail>
    
    
    // MARK: State
    /// Passed as binding to picker at line 38
    @State private var showAlcoholic: Bool = true
    @State private var drinks: [Drink] = []
    
    
    // MARK: Private properties
    
    private let viewModel = CocktailTypeViewModel()
    private var filteredCocktails: [Cocktail] {
        return showAlcoholic ? cocktails.filter { $0.strAlcoholic == "Alcoholic" }
                             : cocktails.filter { $0.strAlcoholic != "Alcoholic" }
    }
    
    
    // MARK: Body
    
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
                if cocktails.isEmpty {
                    Task {
                        drinks = await viewModel.fetchDrinks(with: type ? .alcoholic : .nonAlcoholic)
                    }
                }
            }
            
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    if cocktails.isEmpty {
                        ForEach(drinks) { drink in
                            NavigationLink(destination: CocktailDetailsView(name: drink.strDrink)) {
                                DrinkByCategoryView(drink: drink)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    } else {
                        ForEach(filteredCocktails) { cocktail in
                            NavigationLink {
                                CocktailDetailsView(name: cocktail.unwrappedDrink)
                            } label: {
                                DrinkByCategoryView(drink: Drink(strDrink: cocktail.unwrappedDrink, strDrinkThumb: cocktail.unwrappedThumbnail))
                            }
                        }
                    }
                }
            }
    
            Spacer()
        }
        .navigationBarBackButtonTitleHidden()
        .navigationTitle(showAlcoholic ? "Alcoholic" : "Non Alcoholic")
        .onAppear {
            if cocktails.isEmpty {
                Task {
                    drinks = await viewModel.fetchDrinks(with: showAlcoholic ? .alcoholic : .nonAlcoholic)
                }
            }
        }
    }
    
    
    // MARK: Lifecycle
    
    init(showAlcoholic: Bool) {
        self.showAlcoholic = showAlcoholic
    }
}

struct CocktailTypeView_Previews: PreviewProvider {
    static var previews: some View {
        CocktailTypeView(showAlcoholic: true)
    }
}
