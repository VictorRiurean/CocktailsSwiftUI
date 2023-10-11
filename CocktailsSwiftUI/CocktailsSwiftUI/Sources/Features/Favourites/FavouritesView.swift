//
//  FavouritesView.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 26/01/2023.
//

import SwiftData
import SwiftUI


struct FavouritesView: View {
    
    // MARK: Environment
    
    @Environment(\.modelContext) var modelContext
    
    
    // MARK: Query
    
    @Query(filter: #Predicate<Cocktail> { $0.isFavourite }, sort: \Cocktail.order, order: .forward) var cocktails: [Cocktail]
    
    
    // MARK: State
    
    @State private var showingAlert = false
    @State private var cocktailToDelete: Cocktail?
    
    // MARK: Body
    
    var body: some View {
        NavigationStack {
            if cocktails.isEmpty {
                // MARK: Empty
                Text("Looks like you added no drinks to your favourites list. Please do so by tapping the ❤️")
                    .padding()
                    .navigationTitle("Favourites")
                    .navigationBarTitleDisplayMode(.inline)
            } else {
                // MARK: List
                List {
                    ForEach(cocktails) { cocktail in
                        /// We use the combination of ZStack and empty NavigationLink to hide
                        /// the disclosure chevron that NavigationLinks get by default.
                        ZStack {
                            NavigationLink(destination: CocktailDetailsView(name: cocktail.strDrink)) { }
                                .opacity(0)
                            
                            CocktailCellView(drinkName: cocktail.strDrink)
                                .buttonStyle(PlainButtonStyle())
                        }
                        /// Swipe actions really don't play nice with NavigationLink, especially since we
                        /// also have a button inside the cell. Please see an alternative implementation
                        /// in CocktailTypeView (line 101) that works around these business constraints.
                        /// Furthermore, this is not the only way to add delete swipe actions (but all
                        /// have the same issue). Check out:
                        /// https://www.hackingwithswift.com/quick-start/swiftui/how-to-let-users-delete-rows-from-a-list
                        .swipeActions {
                            Button(role: .destructive) {
                                cocktailToDelete = cocktail
                                
                                showingAlert = true
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                    .onMove(perform: move)
                }
                // MARK: Modifiers
                .navigationTitle("Favourites")
                .navigationBarTitleDisplayMode(.inline)
                .alert("Are you sure you want to delete this cocktail?", isPresented: $showingAlert) {
                    Button("Delete", role: .destructive) {
                        withAnimation {
                            delete(cocktail: cocktailToDelete!)
                            
                            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                        }
                    }
                    
                    Button("Cancel", role: .cancel) { }
                }
                // MARK: onAppear
                .onAppear {
                    for index in 0..<cocktails.count {
                        cocktails[index].order = Int16(index)
                    }
                }
            }
        }
        .navigationBarBackButtonTitleHidden()
    }
    
    
    // MARK: Private methods
    
    private func delete(cocktail: Cocktail) {
        modelContext.delete(cocktail)
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        /// In order for the changes to be persisted the Cocktail object needed to have an order property
        /// added that would be used as SortDescriptor inside the FetchRequest and saved onMove.
        let itemToMove = source.first!
        
        if itemToMove < destination {
            var startIndex = itemToMove + 1
            let endIndex = destination - 1
            var startOrder = cocktails[itemToMove].order
            
            while startIndex <= endIndex {
                cocktails[startIndex].order = startOrder
                
                startOrder += 1
                startIndex += 1
            }
            
            cocktails[itemToMove].order = startOrder
        } else {
            var startIndex = destination
            let endIndex = itemToMove - 1
            var startOrder = cocktails[startIndex].order + 1
            let newOrder = cocktails[startIndex].order
            
            while startIndex <= endIndex {
                cocktails[startIndex].order = startOrder
                
                startOrder += 1
                startIndex += 1
            }
            
            cocktails[itemToMove].order = newOrder
        }
    }
}
