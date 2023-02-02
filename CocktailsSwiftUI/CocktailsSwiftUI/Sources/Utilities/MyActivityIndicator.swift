//
//  MyActivityIndicator.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 30/01/2023.
//

import SwiftUI

public struct MyActivityIndicator: ProgressViewStyle {
    
    // MARK: State
    
    @State private var isAnimating: Bool = false

    
    // MARK: Public methods
    
    public func makeBody(configuration: ProgressViewStyleConfiguration) -> some View {
        VStack {
            ZStack {
                Image(systemName: "circle.hexagonpath.fill")
                    .rotationEffect(Angle(degrees: isAnimating ? 360 : 0.0))
                    .animation(isAnimating ? infiniteAnimation(duration: 1.0) : nil, value: isAnimating)
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 60, height: 60)
        .onAppear {
            isAnimating = true
        }
        .onDisappear {
            isAnimating = false
        }
    }

    
    // MARK: Private methods
    
    private func infiniteAnimation(duration: Double) -> Animation {
        .linear(duration: duration)
        .repeatForever(autoreverses: false)
    }
}
