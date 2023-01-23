//
//  WebService.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 23/01/2023.
//

import Foundation

class WebService {
    
    //MARK: Singleton
    
    static let shared: WebService = WebService()
    
    
    //MARK: Public functions
    
    func fetchCategories() async -> [Category] {
        do {
            let url = try BaseEndpoint.categories.asURL()
            let (data, _) = try await URLSession.shared.data(from: url)
            let categories = try JSONDecoder().decode(Categories.self, from: data)
            
            return categories.drinks
        } catch {
            return []
        }
    }
    
    func fetchRandomCocktail() async -> Drink {
        do {
            let url = try BaseEndpoint.random.asURL()
            let (data, _) = try await URLSession.shared.data(from: url)
            let drinks = try JSONDecoder().decode(Drinks.self, from: data)
            
            return drinks.drinks.first!
        } catch {
            return Drink.surprizeMe
        }
    }
    
    func fetchDrinks(startingWith letter: Character) async -> [Drink] {
        do {
            let url = try BaseEndpoint.alphabetically(letter: letter).asURL()
            let (data, _) = try await URLSession.shared.data(from: url)
            let drinks = try JSONDecoder().decode(Drinks.self, from: data)
            
            return drinks.drinks
        } catch {
            return []
        }
    }
}
