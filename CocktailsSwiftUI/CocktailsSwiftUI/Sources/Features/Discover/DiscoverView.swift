//
//  DiscoverView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

struct DiscoverView: View {
    
    private let viewModel = DiscoverViewModel()
    @State private var drinks: [Drink] = []
    @State private var categories: [Category] = []
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Cocktail Categories")
                    .font(.title)
                
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(categories) { category in
                            CategoryView(category: category)
                        }
                    }
                }
                
                Text("Iconic cocktails")
                    .font(.title)
                
                HStack(spacing: 20) {
                    Spacer()
                    
                    if drinks.count > 0 {
                        IconicCocktail(drink: .surprizeMe)
                        IconicCocktail(drink: drinks[0])
                    }
                    
                    Spacer()
                }
                
                HStack(spacing: 20) {
                    Spacer()
                    
                    if drinks.count > 0 {
                        IconicCocktail(drink: drinks[1])
                        IconicCocktail(drink: drinks[2])
                    }
                    
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    
                    Button {
                        
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
                
                HStack(spacing: 10) {
                    CocktailType(type: .alcoholic)
                    CocktailType(type: .nonalcoholic)
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
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
