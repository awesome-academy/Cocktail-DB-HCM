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
    
    private init() {}
    
    func getAllCocktailByCategory(category: CocktailCategory) -> String {
        return "\(baseURL)\(category.rawValue).php"
    }
    
    func getAllCocktailByName(query: String) -> String {
        return "\(baseURL)search.php?s=\(query)"
    }
}
