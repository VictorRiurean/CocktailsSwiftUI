//
//  LottiePlusView.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 07/02/2023.
//

import Lottie
import SwiftUI

/// We need this implementation of UIViewRepresentable because we want the confetti
/// animation to ignore safe areas and currently plain LottieViews do not have the
/// capacity to do that: https://www.youtube.com/watch?v=kUjHl7zfCeg&t=683s
struct LottiePlusView: UIViewRepresentable {
    
    // MARK: State
    
    @Binding var play: Bool
    
    
    // MARK: Private properties
    
    private let name: String
    private let loopMode: LottieLoopMode
    private let animationSpeed: CGFloat
    private let contentMode: UIView.ContentMode
    
    private let animationView: LottieAnimationView
    
    
    // MARK: Lifecycle
    
    init(
        name: String,
        loopMode: LottieLoopMode = .playOnce,
        animationSpeed: CGFloat = 1,
        contentMode: UIView.ContentMode = .scaleAspectFit,
        play: Binding<Bool> = .constant(true)
    ) {
        self.name = name
        self.animationView = LottieAnimationView(name: name)
        self.loopMode = loopMode
        self.animationSpeed = animationSpeed
        self.contentMode = contentMode
        self._play = play
    }
    
    
    // MARK: Protocol methods
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        
        view.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        animationView.contentMode = contentMode
        animationView.loopMode = loopMode
        animationView.animationSpeed = animationSpeed
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if play {
            animationView.play { _  in
                play = false
            }
        }
    }
}

