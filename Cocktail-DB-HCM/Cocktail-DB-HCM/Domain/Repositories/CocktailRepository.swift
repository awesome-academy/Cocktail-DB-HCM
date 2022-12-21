//
//  CocktailRepository.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 17/12/2022.
//

import Foundation
import RxSwift

protocol CocktailRepositoryType {
    func getListCocktails(category: CocktailCategory) -> Observable<[Cocktail]>
    func getCocktailsByName(query: String) -> Observable<[Cocktail]>
}

struct CocktailRepository: CocktailRepositoryType {
    func getListCocktails(category: CocktailCategory) -> Observable<[Cocktail]> {
        let url = CocktailURLs.shared.getAllCocktailByCategory(category: category)
        return APIService.shared.request(url: url, responseType: CocktailResponse.self)
            .compactMap { $0.drinks }
            .catchAndReturn([])
    }
    
    func getCocktailsByName(query: String) -> Observable<[Cocktail]> {
        let url = CocktailURLs.shared.getAllCocktailByName(query: query)
        return APIService.shared.request(url: url, responseType: CocktailResponse.self)
            .compactMap { $0.drinks }
            .catchAndReturn([])
    }
}
