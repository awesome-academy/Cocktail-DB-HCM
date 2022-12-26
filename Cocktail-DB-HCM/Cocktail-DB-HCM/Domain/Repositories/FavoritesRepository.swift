//
//  FavoritesRepository.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 22/12/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol FavoritesRepositoryType {
    
    func addNewFavoriteCocktail(cocktail: Cocktail) -> Observable<Bool>
    func fetchAllFavoriteCocktail() -> Observable<[Cocktail]>
    func checkForExist(cocktailId: String) -> Observable<Bool>
    func deleteCocktail(cocktailId: String) -> Observable<[Cocktail]>
    func deleteCocktailAt(cocktailId: String) -> Observable<Bool>
}

struct FavoritesRepository: FavoritesRepositoryType {
    
    func addNewFavoriteCocktail(cocktail: Cocktail) -> Observable<Bool> {
        return DatabaseManager.shared.addNewFavoriteCocktail(cocktail: cocktail)
    }
    
    func fetchAllFavoriteCocktail() -> Observable<[Cocktail]> {
        return DatabaseManager.shared.fetchAllFavoriteCocktail()
    }

    func checkForExist(cocktailId: String) -> Observable<Bool> {
        return DatabaseManager.shared.checkForExist(cocktailId: cocktailId)
    }
    
    func deleteCocktail(cocktailId: String) -> Observable<[Cocktail]> {
        return DatabaseManager.shared.deleteCocktail(cocktailId: cocktailId)
    }
    
    func deleteCocktailAt(cocktailId: String) -> Observable<Bool> {
        return DatabaseManager.shared.deleteCocktailAt(cocktailId: cocktailId)
    }
}

