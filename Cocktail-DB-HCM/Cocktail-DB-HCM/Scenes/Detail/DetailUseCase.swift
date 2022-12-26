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
    func checkLikedStatus(cocktailId: String) -> Observable<Bool>
    func addFavoriteCocktail(cocktail: Cocktail) -> Observable<Bool>
    func deleteFavoriteCocktail(cocktailId: String) -> Observable<Bool>
    func checkShoppingStatus(cocktailId: String) -> Observable<Bool>
    func addShoppingCocktail(cocktail: Cocktail) -> Observable<Bool>
    func deleteShoppingCocktail(cocktailId: String) -> Observable<Bool>
}

struct DetailUseCase: DetailUseCaseType {
    
    let cocktailRepository: CocktailRepositoryType
    let favoritesRepository: FavoritesRepositoryType
    let shoppingRepository: ShoppingRepositoryType
    
    func getListCocktails(category: String) -> Observable<[Cocktail]> {
        return cocktailRepository.getFilterCocktailsByCategory(category: category)
    }
    
    func getCocktailDetail(cocktailId: String) -> Observable<CocktailDetail> {
        return cocktailRepository.getCocktailDetail(cocktailId: cocktailId)
    }
    
    func checkLikedStatus(cocktailId: String) -> Observable<Bool> {
        favoritesRepository.checkForExist(cocktailId: cocktailId)
    }
    
    func addFavoriteCocktail(cocktail: Cocktail) -> Observable<Bool> {
        favoritesRepository.addNewFavoriteCocktail(cocktail: cocktail)
    }
    
    func deleteFavoriteCocktail(cocktailId: String) -> Observable<Bool> {
        favoritesRepository.deleteCocktailAt(cocktailId: cocktailId)
    }
    
    func checkShoppingStatus(cocktailId: String) -> Observable<Bool> {
        shoppingRepository.checkForExist(cocktailId: cocktailId)
    }
    
    func addShoppingCocktail(cocktail: Cocktail) -> Observable<Bool> {
        shoppingRepository.addNewShoppingCocktail(cocktail: cocktail)
    }
    
    func deleteShoppingCocktail(cocktailId: String) -> Observable<Bool> {
        shoppingRepository.deleteCocktailAt(cocktailId: cocktailId)
    }
}
