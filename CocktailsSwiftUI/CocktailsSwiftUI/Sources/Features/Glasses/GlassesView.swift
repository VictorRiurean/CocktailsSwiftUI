//
//  GlassesView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

struct GlassesView: View {
    
    @State private var glasses: [Glass] = []
    @State private var searchText = ""
    
    private let viewModel = GlassesViewModel()
    
    private var searchResults: [Glass] {
        if searchText.isEmpty {
            return glasses
        } else {
            return glasses.filter {
                $0.strGlass.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            if glasses.isEmpty {
                ProgressView()
                    .progressViewStyle(DefaultProgressViewStyle())
            } else {
                if searchResults.isEmpty {
                    Text("It seems this glass is not in the list. 😔")
                } else {
                    List {
                        ForEach(searchResults) { glass in
                            ZStack(alignment: .leading) {
                                NavigationLink(destination: GlassesDetailsView(glass: glass.strGlass)) {
                                    EmptyView()
                                }
                                .opacity(0)
                                    
                                Text(glass.strGlass)
                            }
                        }
                    }
                    .navigationTitle("Glasses")
                }
            }
        }
        .onAppear {
            Task {
                glasses = await viewModel.fetchGlasses()
            }
        }
        .searchable(text: $searchText)
        .scrollDismissesKeyboard(.immediately)
    }
}

struct GlassesView_Previews: PreviewProvider {
    static var previews: some View {
        GlassesView()
    }
}
