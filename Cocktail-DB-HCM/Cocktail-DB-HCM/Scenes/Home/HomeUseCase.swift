//
//  HomeUseCase.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import Foundation
import RxSwift

protocol HomeUseCaseType {
    func getListCocktails(category: CocktailCategory) -> Observable<[Cocktail]>
}

struct HomeUseCase: HomeUseCaseType {
    
    let cocktailRepository: CocktailRepositoryType
    
    func getListCocktails(category: CocktailCategory) -> Observable<[Cocktail]> {
        return cocktailRepository.getListCocktails(category: category)
    }
}
