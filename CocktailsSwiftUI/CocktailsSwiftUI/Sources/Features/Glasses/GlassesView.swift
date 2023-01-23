//
//  GlassesView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

struct GlassesView: View {
    
    private let viewModel = GlassesViewModel()
    
    @State private var glasses: [Glass] = []
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(glasses) { glass in
                    Text(glass.strGlass)
                }
            }
            .navigationTitle("Glasses")
        }
        .onAppear {
            Task {
                glasses = await viewModel.fetchGlasses()
            }
        }
        .searchable(text: $searchText)
    }
}

struct GlassesView_Previews: PreviewProvider {
    static var previews: some View {
        GlassesView()
    }
}
