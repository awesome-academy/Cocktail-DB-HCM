//
//  CocktailURLs.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 17/12/2022.
//

import Foundation

struct CocktailURLs {
    static let shared = CocktailURLs()
    
    private let baseURL = "https://www.thecocktaildb.com/api/json/v2/9973533/"
    
    private let baseImageURL = "https://www.thecocktaildb.com/images/ingredients/"
    
    private init() {}
    
    func getAllCocktailByCategory(category: CocktailCategory) -> String {
        return "\(baseURL)\(category.rawValue).php"
    }
    
    func getAllCocktailByName(query: String) -> String {
        return "\(baseURL)search.php?s=\(query)"
    }
    
    func getCocktailDetail(cocktailId: String) -> String {
        return "\(baseURL)lookup.php?i=\(cocktailId)"
    }
    
    func getFilterCocktailByCategory(category: String) -> String {
        let finalCategory = category.isEmpty ? "COCKTAIL" : category
        return "\(baseURL)filter.php?c=\(finalCategory)"
    }
    
    func getIngredientImage(name: String) -> String {
        return "\(baseImageURL)\(name)-Medium.png"
    }
}
