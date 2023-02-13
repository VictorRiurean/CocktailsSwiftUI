//
//  PaginationView.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 13/02/2023.
//

import SwiftUI

struct PaginationView: View {
    
    // MARK: State
    
    @Binding var scrollToIndex: Int
    
    
    // MARK: Public properties
    
    let letters: [String]
    
    
    // MARK: Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            ForEach(letters, id: \.self) { letter in
                Button {
                    scrollToIndex = letters.firstIndex { $0 == letter }!
                } label: {
                    Text(letter)
                        .foregroundColor(.blue)
                        .font(.caption2)
                }
                .contentShape(Rectangle())
            }
        }
    }
}

struct PaginationView_Previews: PreviewProvider {
    static var previews: some View {
        PaginationView(scrollToIndex: .constant(0), letters: ["A", "B", "C"])
    }
}
