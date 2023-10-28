//
//  ListView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftData
import SwiftUI


struct CocktailsView: View {
    
    // MARK: Constants
    
    private enum Constants {
        static let progressViewSize: CGFloat = 100.0
        static let cellWidth: CGFloat = UIScreen.main.bounds.width * 0.9
    }
    
    // MARK: Appstorage
    
    @AppStorage("didFetchAllCocktails") var didFetchAllCocktails = false
    
    
    // MARK: Environment
    
    @Environment(\.modelContext) var modelContext
    
    
    // MARK: FetchRequests
    
    @Query(sort: \Cocktail.strDrink, order: .forward) var cocktails: [Cocktail]
    
    
    // MARK: State
    
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var drinkName = ""
    @State private var isShowingRandomCocktail = false
    
    private var viewModel = CocktailsViewModel()
    
    
    // MARK: Private properties
    
    private var searchResults: [Cocktail] {
        if searchText.isEmpty {
            Array(cocktails)
        } else {
            cocktails.filter { $0.strDrink.localizedStandardContains(searchText.lowercased()) }
        }
    }
    
    private var lettersWithCocktails: [String] {
        viewModel.letters.filter { !sectionIsEmpty($0) }
    }
    
    
    // MARK: Body
    
    var body: some View {
        NavigationStack {
            if searchResults.isEmpty || viewModel.isLoading {
                emptyStateView
            } else {
                ScrollView(.vertical) {
                    LazyVStack {
                        ForEach(lettersWithCocktails, id: \.self) { letter in
                            Section(header: Text("")) {
                                CocktailWithLetterView(
                                    drinkName: $drinkName,
                                    isShowingRandomCocktail: $isShowingRandomCocktail,
                                    cocktails: searchResults,
                                    letter: letter
                                )
                            }
                            .frame(width: Constants.cellWidth)
                            .id(lettersWithCocktails.firstIndex { $0 == letter }!)
                        }
                    }
                }
                .navigationTitle("Cocktails")
                .scrollIndicators(.hidden)
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            }
        }
        .onAppear {
            if !didFetchAllCocktails {
                Task {
                    let cocktails = await viewModel.fetchDrinks()
                        .map { Cocktail(response: $0, modelContext: modelContext) }
                    
                    cocktails.forEach { modelContext.insert($0) }
                    
                    if !cocktails.isEmpty {
                        didFetchAllCocktails = true
                    }
                }
            }
        }
    }
    
    
    // MARK: ViewBuilder
    
    private var emptyStateView: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(width: Constants.progressViewSize, height: Constants.progressViewSize)
                } else {
                    ContentUnavailableView(
                        "No cocktail for that search term 😱",
                        systemImage: "xmark.circle",
                        description: Text("Don't panic, you can add it yourself from the Assistant tab.")
                    )
                }
                
                Spacer()
            }
            
            Spacer()
        }
    }
    
    
    // MARK: Private methods
    
    private func cocktail(with letter: String) -> [Cocktail] {
        cocktails.filter { $0.strDrink.lowercased().starts(with: letter) }
    }
    
    private func sectionIsEmpty(_ letter: String) -> Bool {
        (searchResults.filter { $0.strDrink.lowercased().starts(with: letter) }).isEmpty
    }
}
