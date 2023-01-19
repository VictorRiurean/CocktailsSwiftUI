//
//  DiscoverViewModel.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 19/01/2023.
//

import Foundation

struct DiscoverViewModel {
    func fetchCategories() async -> [Category] {
        guard let url = URL(string: "https://thecocktaildb.com/api/json/v1/1/list.php?c=list") else { fatalError("Bad URL") }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let categories = try JSONDecoder().decode(Categories.self, from: data)
            
            return categories.drinks
        } catch {
            return []
        }
    }
    
    func fetchRandomCocktail() async -> Drink {
        guard let url = URL(string: "https://thecocktaildb.com/api/json/v1/1/random.php") else { fatalError("Bad URL") }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let drinks = try JSONDecoder().decode(Drinks.self, from: data)
            
            return drinks.drinks.first!
        } catch {
            return Drink.surprizeMe
        }
    }
}
