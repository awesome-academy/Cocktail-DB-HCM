//
//  ShoppingRepository.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 23/12/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol ShoppingRepositoryType {
    
    func addNewShoppingCocktail(cocktail: Cocktail) -> Observable<Bool>
    func fetchAllShoppingCocktail() -> Observable<[Cocktail]>
    func checkForExist(cocktailId: String) -> Observable<Bool>
    func deleteCocktail(cocktailId: String) -> Observable<[Cocktail]>
    func deleteCocktailAt(cocktailId: String) -> Observable<Bool>
}

struct ShoppingRepository: ShoppingRepositoryType {
    
    func addNewShoppingCocktail(cocktail: Cocktail) -> Observable<Bool> {
        return DatabaseManager.shared.addNewShoppingCocktail(cocktail: cocktail)
    }
    
    func fetchAllShoppingCocktail() -> Observable<[Cocktail]> {
        return DatabaseManager.shared.fetchAllShoppingCocktail()
    }
    
    func checkForExist(cocktailId: String) -> Observable<Bool> {
        return DatabaseManager.shared.checkForExistShopping(cocktailId: cocktailId)
    }
    
    func deleteCocktail(cocktailId: String) -> Observable<[Cocktail]> {
        return DatabaseManager.shared.deleteShoppingCocktail(cocktailId: cocktailId)
    }
    
    func deleteCocktailAt(cocktailId: String) -> Observable<Bool> {
        return DatabaseManager.shared.deleteShoppingCocktailAt(cocktailId: cocktailId)
    }
}
