//
//  TipsView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 23/01/2023.
//

import SwiftUI

struct TipsView: View {
    
    @State private var isShowingTip = false
    @State private var tip: Tip = Tip.tips.first!
    
    private let tips = Tip.tips
    
    var body: some View {
        List {
            ForEach(tips) { tip in
                TipView(tip: tip)
                    .onTapGesture {
                        self.tip = tip
                        self.isShowingTip = true
                        
                    }
            }
            .navigationTitle("Tips & Tricks")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $isShowingTip) {
            TipDetailsView(isPresented: $isShowingTip, tip: $tip)
        }
    }
}

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        TipsView()
    }
}
