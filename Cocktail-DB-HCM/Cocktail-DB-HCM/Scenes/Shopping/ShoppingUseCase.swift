//
//  ShoppingUseCase.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol ShoppingUseCaseType {
    func getShoppingCocktails() -> Observable<[Cocktail]>
    func deleteShoppingCocktailAt(cocktailId: String) -> Observable<[Cocktail]>
}

struct ShoppingUseCase: ShoppingUseCaseType {
    let shoppingRepository: ShoppingRepository
    
    func getShoppingCocktails() -> Observable<[Cocktail]> {
        return shoppingRepository.fetchAllShoppingCocktail()
    }
    
    func deleteShoppingCocktailAt(cocktailId: String) -> Observable<[Cocktail]> {
        return shoppingRepository.deleteCocktail(cocktailId: cocktailId)
    }

}
