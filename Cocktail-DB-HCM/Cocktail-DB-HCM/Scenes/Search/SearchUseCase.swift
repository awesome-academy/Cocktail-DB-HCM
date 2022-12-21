//
//  SearchUseCase.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import Foundation
import RxSwift

protocol SearchUseCaseType {
    func getCocktailsByName(query: String) -> Observable<[Cocktail]>
}

struct SearchUseCase: SearchUseCaseType {
    let cocktailsRepository: CocktailRepositoryType
    
    func getCocktailsByName(query: String) -> Observable<[Cocktail]> {
        return cocktailsRepository.getCocktailsByName(query: query)
    }
}
