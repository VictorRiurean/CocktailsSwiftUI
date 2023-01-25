//
//  DiscoverView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

struct DiscoverView: View {
    
    @Binding var tabSelection: Int
    
    private let viewModel = DiscoverViewModel()
    @State private var drinks: [Drink] = []
    @State private var categories: [Category] = []
    @State private var isShowingRandomCocktail = false
    @State private var drink: Drink = Drink.surprizeMe
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Cocktail Categories")
                        .font(.title)
                    
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(categories) { category in
                                NavigationLink(destination: CategoryDetailsView(categoryName: category.strCategory)) {
                                    CategoryView(category: category)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    
                    Text("Iconic cocktails")
                        .font(.title)
                    
                    HStack(spacing: 20) {
                        Spacer()
                        
                        if drinks.count > 0 {
                            IconicCocktail(drink: .surprizeMe)
                                .onTapGesture {
                                    Task {
                                        drink = await viewModel.fetchRandomCocktail()
                                        print(drink)
                                        isShowingRandomCocktail = true
                                    }
                                }
                            NavigationLink(destination: CocktailDetailsView(drink: drinks[0])) {
                                IconicCocktail(drink: drinks[0])
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        Spacer()
                    }
                    
                    HStack(spacing: 20) {
                        Spacer()
                        
                        if drinks.count > 0 {
                            NavigationLink(destination: CocktailDetailsView(drink: drinks[1])) {
                                IconicCocktail(drink: drinks[1])
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            NavigationLink(destination: CocktailDetailsView(drink: drinks[2])) {
                                IconicCocktail(drink: drinks[2])
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            tabSelection = 1
                        } label: {
                            Text("Show more")
                                .padding()
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .background(Color.red)
                        .contentShape(Rectangle())
                        .cornerRadius(10)
                        
                        
                        Spacer()
                    }
                    
                    Text("Cocktail types")
                        .font(.title)
                    
                    HStack(spacing: 10) {
                        NavigationLink(destination: CocktailTypeView(showAlcoholic: true)) {
                            CocktailType(type: .alcoholic)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: CocktailTypeView(showAlcoholic: false)) {
                            CocktailType(type: .nonalcoholic)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer()
                }
                .padding()
                .onAppear {
                    Task {
                        drinks = try await withThrowingTaskGroup(of: Drink.self, returning: [Drink].self) { taskGroup in
                            for _ in 0...2 {
                                taskGroup.addTask { await viewModel.fetchRandomCocktail() }
                            }
                            
                            return try await taskGroup.reduce(into: [Drink]()) { partialResult, drink in
                                partialResult.append(drink)
                            }
                        }
                    }
                    
                    Task {
                        categories = await viewModel.fetchCategories()
                    }
                }
                .navigationDestination(isPresented: $isShowingRandomCocktail) {
                    CocktailDetailsView(drink: drink)
                }
            }
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView(tabSelection: .constant(0))
    }
}
