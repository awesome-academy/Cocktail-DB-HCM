//
//  DetailUseCase.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 21/12/2022.
//

import Foundation
import RxSwift

protocol DetailUseCaseType {
    func getListCocktails(category: String) -> Observable<[Cocktail]>
    func getCocktailDetail(cocktailId: String) -> Observable<CocktailDetail>
}

struct DetailUseCase: DetailUseCaseType {
    
    let cocktailRepository: CocktailRepositoryType
    
    func getListCocktails(category: String) -> Observable<[Cocktail]> {
        return cocktailRepository.getFilterCocktailsByCategory(category: category)
    }
    
    func getCocktailDetail(cocktailId: String) -> Observable<CocktailDetail> {
        return cocktailRepository.getCocktailDetail(cocktailId: cocktailId)
    }
}
