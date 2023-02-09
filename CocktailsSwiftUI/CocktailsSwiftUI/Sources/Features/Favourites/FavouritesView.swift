//
//  FavouritesView.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 26/01/2023.
//

import SwiftUI

struct FavouritesView: View {
    
    // MARK: Environment
    
    @Environment(\.managedObjectContext) var moc
    
    
    // MARK: FetchRequests
    
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "\(FilterKey.isFavourite.rawValue) \(PredicateFormat.equalsTo.rawValue) \(FilterValue.yes.rawValue)")) var cocktails: FetchedResults<Cocktail>
    
    
    // MARK: State
    
    @State private var showingAlert = false
    @State private var cocktailToDelete: Cocktail?
    
    // MARK: Body
    
    var body: some View {
        NavigationStack {
            if cocktails.isEmpty {
                Text("Looks like you added no drinks to your favourites list. Please do so by tapping the ❤️")
                    .padding()
                    .navigationTitle("Favourites")
                    .navigationBarTitleDisplayMode(.inline)
            } else {
                List {
                    ForEach(cocktails) { cocktail in
                        /// We use the combination of ZStack and empty NavigationLink to hide
                        /// the disclosure chevron that NavigationLinks get by default.
                        ZStack {
                            NavigationLink(destination: CocktailDetailsView(name: cocktail.unwrappedDrink)) { }
                                .opacity(0)
                            
                            CocktailCellView(drinkName: cocktail.unwrappedDrink)
                                .buttonStyle(PlainButtonStyle())
                        }
                        /// Swipe actions really don't play nice with NavigationLink, especially since we
                        /// also have a button inside the cell. Please see an alternative implementation
                        /// in CocktailTypeView (line 100) that works around these business constraints.
                        /// Furthermore, this is not the only way to add delete swipe actions (but all
                        /// have the same issue). Check out:
                        /// https://www.hackingwithswift.com/quick-start/swiftui/how-to-let-users-delete-rows-from-a-list
                        .swipeActions {
                            Button(role: .destructive) {
                                cocktailToDelete = cocktail
                                
                                showingAlert = true
                            } label: {
                                Label("Delete", systemImage: "minus")
                            }
                        }
                    }
                }
                .navigationTitle("Favourites")
                .navigationBarTitleDisplayMode(.inline)
                .alert("Are you sure you want to delete this cocktail?", isPresented: $showingAlert) {
                    Button("Delete", role: .destructive) {
                        withAnimation {
                            delete(cocktail: cocktailToDelete!)
                        }
                    }
                    
                    Button("Cancel", role: .cancel) { }
                }
            }
        }
        .navigationBarBackButtonTitleHidden()
    }
    
    
    // MARK: Private methods
    
    private func delete(cocktail: Cocktail) {
        moc.delete(cocktail)
        
        try? moc.save()
    }
}
