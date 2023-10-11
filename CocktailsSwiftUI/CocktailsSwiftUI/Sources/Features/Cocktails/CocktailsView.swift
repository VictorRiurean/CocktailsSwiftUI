//
//  ListView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftData
import SwiftUI


struct CocktailsView: View {
    
    // MARK: Environment
    
    @Environment(\.modelContext) var modelContext
    
    
    // MARK: FetchRequests
    
    @Query(sort: \Cocktail.strDrink, order: .forward) var cocktails: [Cocktail]
    
    
    // MARK: State
    
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var drinkName = ""
    @State private var isShowingRandomCocktail = false
    @State private var scrollToIndex = 0
    
    private var viewModel = CocktailsViewModel()
    
    
    // MARK: Private properties
    
    private var searchResults: [Cocktail] {
        if searchText.isEmpty {
            return Array(cocktails)
        } else {
            return cocktails.filter { $0.strDrink.localizedStandardContains(searchText.lowercased()) }
        }
    }
    
    private var lettersWithCocktails: [String] {
        viewModel.letters.filter { !sectionIsEmpty($0) }
    }
    
    
    // MARK: Body
    
    var body: some View {
        NavigationStack {
            /// We use this for the scrollTo(index) functionality it offers (line 164)
            ScrollViewReader { proxy in
                /// We end up only using the Geometry reader to set the PaginationView HStack width,
                /// as for some reason the List ignores the frame given it.
                GeometryReader { geo in
                    ZStack(alignment: .center) {
                        // MARK: Empty
                        if searchResults.isEmpty {
                            VStack {
                                Spacer()
                                
                                HStack {
                                    Spacer()
                                    
                                    if viewModel.isLoading {
                                        ProgressView()
                                            .progressViewStyle(.circular)
                                            .frame(width: 100, height: 100)
                                    } else {
                                        Text("No cocktail for that search term 😱 \n Don't panic, you can add it yourself from the Assistant tab.")
                                            .fixedSize(horizontal: false, vertical: true)
                                            .multilineTextAlignment(.center)
                                    }
                                    
                                    Spacer()
                                }
                                
                                Spacer()
                            }
                        } else {
                            ZStack(alignment: .leading) {
                                // MARK: List
                                List {
                                    ForEach(lettersWithCocktails, id: \.self) { letter in
                                        Section(header: Text(letter)) {
                                            CocktailWithLetterView(
                                                drinkName: $drinkName,
                                                isShowingRandomCocktail: $isShowingRandomCocktail,
                                                cocktails: searchResults,
                                                letter: letter
                                            )
                                        }
                                        .id(lettersWithCocktails.firstIndex { $0 == letter }!)
                                    }
                                }
                                .navigationTitle("Cocktails")
                                .scrollIndicators(.hidden)
                                .onChange(of: scrollToIndex) { _, newValue in
                                    withAnimation {
                                        proxy.scrollTo(newValue, anchor: .top)
                                    }
                                }
                            
                                // MARK: PaginationView
                                VStack {
                                    Spacer()
                                    
                                    HStack {
                                        PaginationView(
                                            scrollToIndex: $scrollToIndex,
                                            letters: lettersWithCocktails.map { $0.capitalized }
                                        )
                                        .padding()
                                        
                                        Spacer()
                                    }
                                    
                                    Spacer()
                                }
                                .frame(width: geo.size.width * 0.15)
                            }
                        }
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            // MARK: onAppear
            .onAppear {
                if cocktails.isEmpty {
                    Task {
                        let cocktails = await viewModel.fetchDrinks()
                            .map { Cocktail(response: $0, modelContext: modelContext) }
                        
                        cocktails.forEach { modelContext.insert($0) }
                    }
                }
            }
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

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        CocktailsView()
    }
}

// MARK: - Extracted Views

struct CocktailWithLetterView: View {
    
    // MARK: State
    
    @Binding var drinkName: String
    @Binding var isShowingRandomCocktail: Bool
    
    
    // MARK: Private properties
    
    fileprivate let cocktails: [Cocktail]
    fileprivate let letter: String
    
    
    // MARK: Body
    
    var body: some View {
        ForEach(cocktail(with: letter)) { cocktail in
            /// This was the only navigation that was working properly with LazyVStack.
            /// Also, swipeAction and onDelete don't work properly with LazyVStacks.
            CocktailCellView(drinkName: cocktail.strDrink, letter: letter)
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                .onTapGesture {
                    drinkName = cocktail.strDrink
                    isShowingRandomCocktail = true
                }
                .navigationDestination(isPresented: $isShowingRandomCocktail) {
                    CocktailDetailsView(name: drinkName)
                }
        }
    }
    
    
    // MARK: Private methods
    
    fileprivate func cocktail(with letter: String) -> [Cocktail] {
        cocktails.filter { $0.strDrink.lowercased().starts(with: letter) }
    }
}
