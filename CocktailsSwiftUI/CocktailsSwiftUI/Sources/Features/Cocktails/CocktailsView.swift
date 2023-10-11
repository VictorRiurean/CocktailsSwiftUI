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
    
    
    // MARK: Storage
    
    @AppStorage(StorageKeys.allLettersLoaded.rawValue) var allLettersLoaded: Bool = false
    @AppStorage(StorageKeys.loadedLetters.rawValue) var loadedLetters: Data = Data()
    
    
    // MARK: State
    
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var drinkName = ""
    @State private var isShowingRandomCocktail = false
    @State private var scrollToIndex = 0
    /// According to the resources I've found when it comes to choosing between @StateObject and @ObservedObject
    /// the rule of thumb would be: if the object will be used throughout a navigation stack then you want to
    /// declare it at @StateObject in the parent and then as @ObservedObject in all of the children. @StateObject
    /// guarantees that the object will exist before invoking the body function (properties marked with state
    /// are stored outside of the view they belong to), whereas if we use @ObservedObject there's no such guarantee:
    /// https://www.youtube.com/watch?v=VLUhZbz4arg
    /// If you are curious to see @ObservedObject failing, check this out:
    /// https://www.youtube.com/watch?v=5ryXee_Ye3k&t=111s
    @ObservedObject private var viewModel = CocktailsViewModel()
    
    
    // MARK: Private properties
    
    private var searchResults: [Cocktail] {
        if searchText.isEmpty {
            return Array(cocktails)
        } else {
            return cocktails.filter { $0.strDrink.localizedStandardContains(searchText.lowercased()) }
        }
    }
    private var letters: [String] {
        Storage.loadStringArray(data: loadedLetters)
    }
    
    
    // MARK: Body
    
    var body: some View {
        NavigationStack {
            /// We use this for the scrollTo(index) functionality it offers (line 164)
            ScrollViewReader { proxy in
                /// We end up only using the Geometry reader to set the PaginationView HStack width,
                /// as for some reason the List ignores the frame given it.
                GeometryReader { geo in
                    ZStack {
                        // MARK: Empty
                        if searchResults.isEmpty {
                            VStack {
                                Spacer()
                                
                                HStack {
                                    Spacer()
                                    
                                    Text("No cocktail for that search term 😱 \n Don't panic, you can add it yourself from the Assistant tab.")
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                    
                                    Spacer()
                                }
                                
                                Spacer()
                            }
                        } else {
                            ZStack(alignment: .leading) {
                                // MARK: List
                                List {
                                    ForEach(letters, id: \.self) { letter in
                                        if !sectionIsEmpty(letter) {
                                            Section(header: Text(letter)) {
                                                CocktailWithLetterView(
                                                    drinkName: $drinkName,
                                                    isShowingRandomCocktail: $isShowingRandomCocktail,
                                                    cocktails: searchResults,
                                                    letter: letter
                                                )
                                            }
                                            .id(letters.firstIndex { $0 == letter }!)
                                        }
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
                                            letters: letters.compactMap {
                                                if !sectionIsEmpty($0) {
                                                    return $0.capitalized
                                                } else {
                                                    return nil
                                                }
                                            }
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
                if !allLettersLoaded {
                    Task {
                        let cocktails = await viewModel.fetchDrinks(loadedLetters: Storage.loadStringArray(data: loadedLetters))
                            .map { Cocktail(response: $0, modelContext: modelContext) }
                        
                        cocktails.forEach { modelContext.insert($0) }
                        
                        loadedLetters = Storage.archiveStringArray(object: viewModel.loadedLetters)
                        allLettersLoaded = viewModel.allLettersLoaded
                    }
                }
            }
        }
    }
    
    
    // MARK: Private methods
    
    private func fetchDrinks() async {
        let cocktails = await viewModel.fetchDrinks(loadedLetters: Storage.loadStringArray(data: loadedLetters))
            .map { Cocktail(response: $0, modelContext: modelContext) }
        
        if !cocktails.isEmpty {
            cocktails.forEach { modelContext.insert($0) }
            
            loadedLetters = Storage.archiveStringArray(object: viewModel.loadedLetters)
            allLettersLoaded = viewModel.allLettersLoaded
        }
    }
    
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
