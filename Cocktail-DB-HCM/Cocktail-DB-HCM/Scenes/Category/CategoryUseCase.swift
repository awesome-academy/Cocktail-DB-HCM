//
//  CategoryUseCase.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 27/12/2022.
//

import Foundation
import RxSwift

protocol CategoryUseCaseType {
    func getListCocktails(category: CocktailCategory) -> Observable<[Cocktail]>
}

struct CategoryUseCase: CategoryUseCaseType {
    let cocktailsRepository: CocktailRepositoryType
    
    func getListCocktails(category: CocktailCategory) -> Observable<[Cocktail]> {
        return cocktailsRepository.getListCocktails(category: category)
    }
}
