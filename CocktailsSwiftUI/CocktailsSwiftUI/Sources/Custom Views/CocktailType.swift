//
//  CocktailType.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 18/01/2023.
//

import SwiftUI

struct CocktailType: View {
    
    // MARK: Cocktail Type
    
    enum CocktailType: Equatable {
        case alcoholic
        case nonalcoholic
    }
    
    
    // MARK: Environment
    
    @Environment(\.colorScheme) var colorScheme
    
    
    // MARK: Private properties
    
    private let type: CocktailType
    private var text: String {
        switch type {
        case .alcoholic:
            return "Alcoholic"
        case .nonalcoholic:
            return "Non-alcoholic"
        }
    }
    
    
    // MARK: Body
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [
                colorScheme == .light ? AppColors.lightColors.randomElement()! : AppColors.darkColors.randomElement()!,
                colorScheme == .light ? AppColors.lightColors.randomElement()! : AppColors.darkColors.randomElement()!
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
    
    
    // MARK: Lifecycle
    
    init(type: CocktailType) {
        self.type = type
    }
}

struct CocktailType_Previews: PreviewProvider {
    static var previews: some View {
        CocktailType(type: .alcoholic)
    }
}
