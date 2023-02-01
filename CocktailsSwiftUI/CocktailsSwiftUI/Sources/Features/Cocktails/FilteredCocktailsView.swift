//
//  FilteredCocktailsView.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 31/01/2023.
//

import CoreData
import SwiftUI

struct FilteredCocktailsView<T: NSManagedObject & Identifiable, Content: View>: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest var fetchRequest: FetchedResults<T>
    
    @ObservedObject var viewModel = FilteredCocktailsViewModel()
    
    @State var drinks: [Drink] = []
    
    var content: (T) -> Content
    
    var body: some View {
        NavigationStack {
            List(fetchRequest, id: \.self) { item in
                self.content(item)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
    
    init(filterKey: FilterKey, filterValue: String, format: PredicateFormat, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K \(format.rawValue) %@", filterKey.rawValue, filterValue))
        
        self.content = content
    }
}
