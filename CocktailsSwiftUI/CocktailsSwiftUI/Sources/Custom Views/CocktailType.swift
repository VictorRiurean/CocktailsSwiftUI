//
//  CocktailType.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

struct CocktailType: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    enum CType: Equatable {
        case alcoholic
        case nonalcoholic
    }
    
    private let type: CType
    private var text: String {
        switch type {
        case .alcoholic:
            return "Alcoholic"
        case .nonalcoholic:
            return "Non-alcoholic"
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [
                colorScheme == .light ? AppColors.getRandomLightColor() : AppColors.getRandomDarkColor(),
                colorScheme == .light ? AppColors.getRandomLightColor() : AppColors.getRandomDarkColor()
            ],
                           startPoint: type == .alcoholic ? .topLeading : .bottomTrailing,
                           endPoint: type == .alcoholic ? .topTrailing : .bottomLeading)
            
            Text(text)
                .font(.headline)
        }
        .frame(minHeight: 150)
        .frame(maxWidth: .infinity)
        .cornerRadius(15)
        .padding()
    }
    
    init(type: CType) {
        self.type = type
    }
}

struct CocktailType_Previews: PreviewProvider {
    static var previews: some View {
        CocktailType(type: .alcoholic)
    }
}
