//
//  TipsView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 23/01/2023.
//

import SwiftUI

struct TipsView: View {
    
    private let tips = Tip.tips
    
    var body: some View {
        List {
            ForEach(tips) { tip in
                TipView(tip: tip)
            }
        }
        .navigationTitle("Tips & Tricks")
    }
}

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        TipsView()
    }
}
