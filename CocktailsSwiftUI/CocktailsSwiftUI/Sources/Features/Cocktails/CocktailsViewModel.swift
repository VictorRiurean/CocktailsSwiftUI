//
//  CocktailsViewModel.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 19/01/2023.
//

import Foundation

struct CocktailsViewModel {
    func fetchDrinks() async -> [Drink] {
        guard let url = URL(string: "https://thecocktaildb.com/api/json/v1/1/search.php?f=a") else { fatalError("Bad URL") }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let drinks = try JSONDecoder().decode(Drinks.self, from: data)
            
            return drinks.drinks
        } catch {
            return []
        }
    }
}
