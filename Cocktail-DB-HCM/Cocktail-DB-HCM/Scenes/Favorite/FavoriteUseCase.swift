//
//  FavoriteUseCase.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol FavoriteUseCaseType {
    func getFavoriteCocktails() -> Observable<[Cocktail]>
    func deleteFavoriteCocktailAt(cocktailId: String) -> Observable<[Cocktail]>
}

struct FavoriteUseCase: FavoriteUseCaseType {
    let favoritesRepository: FavoritesRepositoryType
    
    func getFavoriteCocktails() -> Observable<[Cocktail]> {
        return favoritesRepository.fetchAllFavoriteCocktail()
    }
    
    func deleteFavoriteCocktailAt(cocktailId: String) -> Observable<[Cocktail]> {
        return favoritesRepository.deleteCocktail(cocktailId: cocktailId)
    }
}
