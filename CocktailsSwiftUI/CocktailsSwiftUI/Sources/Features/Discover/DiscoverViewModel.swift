//
//  Discoverswift
//  CocktailsSwiftUI
//
//  Created by Victor on 19/01/2023.
//

import Observation


@Observable class DiscoverViewModel {
    
    // MARK: Public properties
    
    var drinksLoaded = false
    var categories: [Category] = []
    
    
    // MARK: Private properties
    
    private let service = WebService.shared
    
    
    // MARK: Public functions
    
    func loadDrinks() async -> [CocktailResponse] {
        var drinks = [CocktailResponse]()
        
        drinks = await withTaskGroup(of: CocktailResponse.self, returning: [CocktailResponse].self) { taskGroup in
            for _ in 0 ... 3 {
                taskGroup.addTask { await self.fetchRandomCocktail() }
            }
            
            for await result in taskGroup {
                drinks.append(result)
            }
            
            return drinks
        }
        
        drinksLoaded = true
        
        return drinks
    }
    
    func fetchCategories() async {
        categories = await service.fetchCategories()
    }
    
    func fetchRandomCocktail() async -> CocktailResponse {
        await service.fetchRandomCocktail()
    }
}
