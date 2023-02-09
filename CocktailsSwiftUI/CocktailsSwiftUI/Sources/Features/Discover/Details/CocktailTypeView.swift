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

// MARK: CATCH-22
/// The plan was to have a ListView that was not embedded inside a NavigationStack
/// and just show the CocktailDetailsView in a sheet. I wanted to toggle the
/// showSheet boolean inside an onTapGesture modifier added to the cells and
/// also set the cocktail to be shown in that closure. This turned out not to work
/// because we are dealing with a list, so we can't know the navigation destination
/// beforehand, but when we try to pass the cocktail to be shown via a @State var
/// we get a crash (line 202) because the viewBuilder inside the sheet is set when
/// the parent view is first created, thus name is nil (this happens because @State
/// variables are stored outside their containig view). And if instead we remove
/// the @State modifier then we get a runtime error because we are trying to
/// mutate an immutable self (trying to change it inside a mutating func yields
/// the same error), hence the name of the struct. If you want to try all this
/// out, you can just change the cell type in discoverView line 128 to a Catch22View.
struct Catch22View: View {
    
    // MARK: Environment
    
    @Environment(\.managedObjectContext) var moc
    
    // MARK: FetchRequests
    
    @FetchRequest(sortDescriptors: []) var cocktails: FetchedResults<Cocktail>
    
    
    // MARK: State
    
    @State private var showAlcoholic: Bool = true
    @State private var drinks: [Drink] = []
    @State private var showCocktailDetails: Bool = false
    @State private var name: String?
    
    
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
            
            List {
                if cocktails.isEmpty {
                    ForEach(drinks) { drink in
                        CocktailCellView(drinkName: drink.strDrink)
                            .buttonStyle(PlainButtonStyle())
                            .onTapGesture {
                                name = drink.strDrink
                                
                                showCocktailDetails = true
                            }
                    }
                    /// By default this apparently performs method with animation (I'm assuming this
                    /// based on the fact that there is a constructor named performWithoutAnimation)
                    .onDelete(perform: deleteDrink)
                } else {
                    ForEach(filteredCocktails) { cocktail in
                        CocktailCellView(drinkName: cocktail.unwrappedDrink)
                            .buttonStyle(PlainButtonStyle())
                            .onTapGesture {
                                name = cocktail.unwrappedDrink
                                
                                showCocktailDetails = true
                            }
                    }
                    .onDelete(perform: deleteCocktail)
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
        .sheet(isPresented: $showCocktailDetails) {
            CocktailDetailsView(name: name!)
        }
    }
    
    
    // MARK: Lifecycle
    
    init(showAlcoholic: Bool) {
        self.showAlcoholic = showAlcoholic
    }
    
    
    // MARK: Private methods
    
    private func deleteDrink(at offsets: IndexSet) {
        drinks.remove(atOffsets: offsets)
    }
    
    private func deleteCocktail(at offsets: IndexSet) {
        moc.delete(cocktails[offsets.first!])
        
        try? moc.save()
    }
}

