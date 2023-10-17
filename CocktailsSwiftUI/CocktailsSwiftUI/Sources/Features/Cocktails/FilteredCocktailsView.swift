//
//  FilteredCocktailsView.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 31/01/2023.
//

import CoreData
import SwiftUI

/// I ended up not using this Struct anywhere because I wanted to also have
/// a few instances of non-generic fetch reuqests. I will keep it in the
/// app though because it is a very nice and very reusable piece of code.
struct FilteredCocktailsView<T: NSManagedObject & Identifiable, Content: View>: View {
    
    // MARK: Environment
    
    @Environment(\.modelContext) var modelContext
    
    
    // MARK: FetchRequests
    
    @FetchRequest var fetchRequest: FetchedResults<T>
    
    
    // MARK: State
    
    @State var drinks: [CocktailResponse] = []
    
    
    // MARK: Private properties
    
    private var content: (T) -> Content
    
    
    // MARK: Body
    
    var body: some View {
        NavigationStack {
            List(fetchRequest) { item in
                self.content(item)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
    
    
    // MARK: Lifecycle
    /// This is how you can have dynamically set fetchRequests in SwiftUI. This one also uses generic types that play nice
    /// with both core data due to NSManagedObject conformance and ForEach due to Identifiable conformance. Call it thusly
    //    FilteredCocktailsView(filterKey: .drinkName, filterValue: letter, format: .beginsWith) { (cocktail: Cocktail) in
    //        CocktailCellView(drinkName: cocktail.unwrappedDrink)
    //    }
    /// The view we pass in at line 52 (which you would normally call from a parent view) will populate the List at line 41
    init(filterKey: FilterKey, filterValue: String, format: PredicateFormat, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K \(format.rawValue) %@", filterKey.rawValue, filterValue))
        
        self.content = content
    }
}
