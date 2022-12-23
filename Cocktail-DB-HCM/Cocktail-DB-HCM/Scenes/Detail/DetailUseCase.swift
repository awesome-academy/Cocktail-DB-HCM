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
    func addMovie(cocktail: Cocktail) -> Observable<Bool>
    func deleteMovie(cocktailId: String) -> Observable<Bool>
}

struct DetailUseCase: DetailUseCaseType {
    
    let cocktailRepository: CocktailRepositoryType
    let favoritesRepository: FavoritesRepositoryType
    
    func getListCocktails(category: String) -> Observable<[Cocktail]> {
        return cocktailRepository.getFilterCocktailsByCategory(category: category)
    }
    
    func getCocktailDetail(cocktailId: String) -> Observable<CocktailDetail> {
        return cocktailRepository.getCocktailDetail(cocktailId: cocktailId)
    }
    
    func checkLikedStatus(cocktailId: String) -> Observable<Bool> {
        favoritesRepository.checkForExist(cocktailId: cocktailId)
    }
    
    func addMovie(cocktail: Cocktail) -> Observable<Bool> {
        favoritesRepository.addNewFavoriteCocktail(cocktail: cocktail)
    }
    
    func deleteMovie(cocktailId: String) -> Observable<Bool> {
        favoritesRepository.deleteMovieAt(cocktailId: cocktailId)
    }
}
