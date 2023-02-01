//
//  Endpoints.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 23/01/2023.
//

import Foundation

enum URLError: Error {
    case badURL(url: BaseEndpoint)
}

struct BaseURL {
    static let scheme = "https"
    static let host = "thecocktaildb.com"
    static let path = "/api/json/v1/1"
}

enum BaseEndpoint {
    case random
    case categories
    case byCategory(name: String)
    case alphabetically(letter: String)
    case type(type: DrinkType)
    case search(forDrink: String)
    case ingredients
    case byIngredient(name: String)
    case glasses
    case byGlass(name: String)
    
    private var path: String {
        switch self {
        case .random:
            return "/random.php"
        case .categories, .ingredients, .glasses:
            return "/list.php"
        case .alphabetically, .search:
            return "/search.php"
        case .byCategory, .type, .byIngredient, .byGlass:
            return "/filter.php"
        }
    }
    
    func asURL() throws -> URL {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = BaseURL.scheme
        urlComponents.host = BaseURL.host
        urlComponents.path = "\(BaseURL.path)\(path)"
        
        switch self {
        case .categories:
            urlComponents.queryItems = [
                URLQueryItem(name: "c", value: "list")
            ]
        case .byCategory(let name):
            urlComponents.queryItems = [
                URLQueryItem(name: "c", value: name)
            ]
        case .alphabetically(letter: let letter):
            urlComponents.queryItems = [
                URLQueryItem(name: "f", value: letter)
            ]
        case .type(let type):
            urlComponents.queryItems = [
                URLQueryItem(name: "a", value: type.rawValue)
            ]
        case .search(let drink):
            urlComponents.queryItems = [
                URLQueryItem(name: "s", value: drink)
            ]
        case .ingredients:
            urlComponents.queryItems = [
                URLQueryItem(name: "i", value: "list")
            ]
        case .byIngredient(let name):
            urlComponents.queryItems = [
                URLQueryItem(name: "i", value: name)
            ]
        case .glasses:
            urlComponents.queryItems = [
                URLQueryItem(name: "g", value: "list")
            ]
        case .byGlass(let name):
            urlComponents.queryItems = [
                URLQueryItem(name: "g", value: name)
            ]
        default:
            break
        }
        
        guard let url = urlComponents.url else { throw URLError.badURL(url: self) }
        
        return url
    }
}

struct IngredientsBaseURL {
    static let url = "https://thecocktaildb.com/images/ingredients/"
    static let suffix = "-Small.png"
}
