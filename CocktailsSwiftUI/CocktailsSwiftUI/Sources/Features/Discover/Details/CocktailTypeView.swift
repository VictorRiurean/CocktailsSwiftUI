//
//  CocktailTypeView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 24/01/2023.
//

import SwiftData
import SwiftUI


struct CocktailTypeView: View {
    
    // MARK: Constants
    
    private enum Constants {
        static let containerStackSpacing: CGFloat = 10.0
        static let pickerWidth: CGFloat = UIScreen.main.bounds.width * 0.75
        static let lazyVGridInsets: EdgeInsets = EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
    }
    
    
    // MARK: FetchRequests
    
    @Query var cocktails: [Cocktail]
    
    
    // MARK: State
    
    @State private var showAlcoholic: Bool = true
    @State private var drinks: [CocktailResponse] = []
    
    
    // MARK: Private properties
    
    private let viewModel = CocktailTypeViewModel()
    private var filteredCocktails: [Cocktail] {
        return showAlcoholic ? cocktails.filter { $0.strAlcoholic == "Alcoholic" }
                             : cocktails.filter { $0.strAlcoholic != "Alcoholic" }
    }
    
    
    // MARK: Body
    
    var body: some View {
        VStack(spacing: Constants.containerStackSpacing) {
            Text("Discover the cocktails in this category")
            
            Picker("", selection: $showAlcoholic) {
                Text("Alcoholic").tag(true)
                Text("Non Alcoholic").tag(false)
            }
            .pickerStyle(.segmented)
            .frame(maxWidth: Constants.pickerWidth)
            .onChange(of: showAlcoholic) {
                if cocktails.isEmpty {
                    Task {
                        drinks = await viewModel.fetchDrinks(with: showAlcoholic ? .alcoholic : .nonAlcoholic)
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
                                CocktailDetailsView(name: cocktail.strDrink)
                            } label: {
                                DrinkByCategoryView(
                                    drink: CocktailResponse(
                                        strDrink: cocktail.strDrink,
                                        strDrinkThumb: cocktail.strDrinkThumb
                                    )
                                )
                            }
                        }
                    }
                }
                .padding(Constants.lazyVGridInsets)
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
