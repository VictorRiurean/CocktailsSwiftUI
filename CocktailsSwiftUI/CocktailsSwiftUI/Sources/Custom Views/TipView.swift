//
//  TipView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 23/01/2023.
//

import SwiftUI

struct TipView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    private let tip: Tip
    
    var body: some View {
        HStack {
            tip.image
                .resizable()
                .frame(width: 75, height: 75)
                .padding()
                .cornerRadius(5)
            
            Text(tip.shortDescription)
                .font(.headline)
            
            Spacer()
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(colorScheme == .light ? AppColors.getRandomLightColor() : AppColors.getRandomDarkColor())
        .cornerRadius(15)
    }
    
    init(tip: Tip) {
        self.tip = tip
    }
}

struct TipView_Previews: PreviewProvider {
    static var previews: some View {
        TipView(tip: Tip.tips.first!)
    }
}
