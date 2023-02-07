//
//  LottieView.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 07/02/2023.
//

import Lottie
import SwiftUI
/// I ended up not using this view because I needed the confetti
/// to ignoreSafeAreas. I'll leave it in because it showcases
/// a basic implementation of UIViewRepresentable
struct LottieView: UIViewRepresentable {
    
    // MARK: Animation names
    
    enum Animations: String, CaseIterable {
        case confetti
        case chick = "cool-chick"
        case drink = "summer-drink"
        case gift = "surprise-gift-box"
        case like = "like-5x"
    }
    
    
    // MARK: Private properties
    
    private let name: String
    private let loopMode: LottieLoopMode
    private let animationSpeed: CGFloat
    
    
    // MARK: Lifecycle
    
    init(
        name: String,
        loopMode: LottieLoopMode = .playOnce,
        animationSpeed: CGFloat = 1
    ) {
        self.name = name
        self.loopMode = loopMode
        self.animationSpeed = animationSpeed
    }
    
    
    // MARK: Protocol methods
    
    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: name)
        
        animationView.loopMode = loopMode
        animationView.animationSpeed = animationSpeed
        animationView.play()
        
        return animationView
    }
    
    func updateUIView(_ uiView: Lottie.LottieAnimationView, context: Context) {
        
    }
}
