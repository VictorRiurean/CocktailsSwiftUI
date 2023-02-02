//
//  UIApplication+Window.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 02/02/2023.
//

import UIKit

public extension UIApplication {
    func currentUIWindow() -> UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
        
        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }
        
        return window
    }
}
