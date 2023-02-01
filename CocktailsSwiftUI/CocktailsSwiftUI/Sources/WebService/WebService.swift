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
    
    /// Generic request
    /// - Parameter url: endpoint
    /// - Returns: T where T is Decodable
    /// I wrote this just for kicks, we won't be able to actually use it because of the weird way the data is nested in our JSON responses
    func request<T: Decodable>(from url: URL) async -> [T] {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let list = try JSONDecoder().decode([T].self, from: data)
            
            return list
        } catch {
            return []
        }
    }
    
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
    
    func fetchByCategory(name: String) async -> [Drink] {
        do {
            let url = try BaseEndpoint.byCategory(name: name).asURL()
            let (data, _) = try await URLSession.shared.data(from: url)
            let drinks = try JSONDecoder().decode(Drinks.self, from: data)
            
            return drinks.drinks
        } catch {
            return []
        }
    }
    
    func fetchByIngredient(name: String) async -> [Drink] {
        do {
            let url = try BaseEndpoint.byIngredient(name: name).asURL()
            let (data, _) = try await URLSession.shared.data(from: url)
            let drinks = try JSONDecoder().decode(Drinks.self, from: data)
            
            return drinks.drinks
        } catch {
            return []
        }
    }
    
    func fetchByGlass(name: String) async -> [Drink] {
        do {
            let url = try BaseEndpoint.byGlass(name: name).asURL()
            let (data, _) = try await URLSession.shared.data(from: url)
            let drinks = try JSONDecoder().decode(Drinks.self, from: data)
            
            return drinks.drinks
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
    
    func fetchDrinks(with letter: String) async -> [Drink] {
        do {
            let url = try BaseEndpoint.alphabetically(letter: letter).asURL()
            let (data, _) = try await URLSession.shared.data(from: url)
            let drinks = try JSONDecoder().decode(Drinks.self, from: data)
            
            return drinks.drinks
        } catch {
            return []
        }
    }
    
    func fetchDrinks(with type: DrinkType) async -> [Drink] {
        do {
            let url = try BaseEndpoint.type(type: type).asURL()
            let (data, _) = try await URLSession.shared.data(from: url)
            let drinks = try JSONDecoder().decode(Drinks.self, from: data)
            
            return drinks.drinks
        } catch {
            return []
        }
    }
    
    func fetchDrink(with name: String) async -> Drink {
        do {
            let url = try BaseEndpoint.search(forDrink: name).asURL()
            let (data, _) = try await URLSession.shared.data(from: url)
            let drinks = try JSONDecoder().decode(Drinks.self, from: data)
            
            return drinks.drinks.first!
        } catch {
            return Drink(strDrink: "Wow", strCategory: "Wow", strAlcoholic: "Wow", strGlass: "Wow")
        }
    }
    
    func fetchGlasses() async -> [Glass] {
        do {
            let url = try BaseEndpoint.glasses.asURL()
            let (data, _) = try await URLSession.shared.data(from: url)
            let glasses = try JSONDecoder().decode(Glasses.self, from: data)
            
            return glasses.drinks
        } catch {
            return []
        }
    }
    
    func fetchIngredients() async -> [Ingredient] {
        do {
            let url = try BaseEndpoint.ingredients.asURL()
            let (data, _) = try await URLSession.shared.data(from: url)
            let ingredients = try JSONDecoder().decode(Ingredients.self, from: data)
            
            return ingredients.drinks
        } catch {
            return []
        }
    }
}
