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
}

struct CocktailRepository: CocktailRepositoryType {
    func getListCocktails(category: CocktailCategory) -> Observable<[Cocktail]> {
        let url = CocktailURLs.shared.getAllCocktailByCategory(category: category)
        return APIService.shared.request(url: url, responseType: CocktailResponse.self)
            .compactMap { response -> [Cocktail] in
                guard let cocktails = response.drinks else { return [] }
                return cocktails
            }
            .catchAndReturn([])
    }
}
