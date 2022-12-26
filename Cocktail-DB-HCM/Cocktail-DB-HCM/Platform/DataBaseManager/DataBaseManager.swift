//
//  FavortiteCocktailEntity.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 22/12/2022.
//

import Foundation
import RxSwift
import Then
import CoreData

final class DatabaseManager {
    static let shared = DatabaseManager()
    private let presistentContainer: NSPersistentContainer
    
    private init() {
        presistentContainer = NSPersistentContainer(name: "CocktailDatabase").with {
            $0.loadPersistentStores { (_, error) in
                if let error = error {
                    print("Load CocktailDatabase failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func checkForExist(cocktailId: String) -> Observable<Bool> {
        let context = presistentContainer.viewContext
        let request = CocktailEntity.fetchRequest() as NSFetchRequest<CocktailEntity>
        
        return Observable.create { observer in
            do {
                let cocktails = try context.fetch(request)
                observer.onNext(cocktails.contains(where: { $0.id == cocktailId }))
                observer.onCompleted()
            } catch {
                observer.onError(DatabaseError.checkCocktailExistFailed)
            }
            return Disposables.create()
        }
    }
    
    func addNewFavoriteCocktail(cocktail: Cocktail) -> Observable<Bool> {
        let context = presistentContainer.viewContext
        
        return Observable.create { observer in
            do {
                CocktailEntity(context: context).do {
                    $0.id = cocktail.id
                    $0.strDrink = cocktail.strDrink
                    $0.strCategory = cocktail.strCategory
                    $0.strGlass = cocktail.strGlass
                    $0.strAlcoholic = cocktail.strAlcoholic
                    $0.strDrinkThumb = cocktail.strDrinkThumb
                    $0.strInstructions = cocktail.strInstructions
                }
                try context.save()
                observer.onNext(true)
                observer.onCompleted()
            } catch {
                observer.onError(DatabaseError.addCocktailFailed)
            }
            return Disposables.create()
        }
    }
    
    func deleteCocktail(cocktailId: String) -> Observable<[Cocktail]> {
        let context = presistentContainer.viewContext
        let request = CocktailEntity.fetchRequest() as NSFetchRequest<CocktailEntity>
        
        return Observable.create { observer in
            do {
                if let cocktailsEntity = try? context.fetch(request) {
                    if let cocktail = cocktailsEntity.first(where: { $0.id == cocktailId }) {
                        context.delete(cocktail)
                        try context.save()
                    }
                    if let cocktailsEntityAfterDelete = try? context.fetch(request) {
                        observer.onNext(self.entityToCocktails(entities: cocktailsEntityAfterDelete))
                        observer.onCompleted()
                    }
                }
            } catch {
                observer.onError(DatabaseError.deleteCocktailFailed)
            }
            return Disposables.create()
        }
    }
    
    func deleteCocktailAt(cocktailId: String) -> Observable<Bool> {
        let context = presistentContainer.viewContext
        let request = CocktailEntity.fetchRequest() as NSFetchRequest<CocktailEntity>
        
        return Observable.create { observer in
            do {
                if let cocktails = try? context.fetch(request) {
                    for cocktail in cocktails where cocktail.id == cocktailId {
                        context.delete(cocktail)
                        try context.save()
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                }
            } catch {
                observer.onError(DatabaseError.deleteCocktailFailed)
            }
            return Disposables.create()
        }
    }
    
    func fetchAllFavoriteCocktail() -> Observable<[Cocktail]> {
        let context = presistentContainer.viewContext
        return Observable.create { observer in
            do {
                let request = CocktailEntity.fetchRequest() as NSFetchRequest<CocktailEntity>
                let cocktailsEntity = try context.fetch(request)
                
                observer.onNext(self.entityToCocktails(entities: cocktailsEntity))
                observer.onCompleted()
            } catch {
                observer.onError(DatabaseError.getAllCocktailFailed)
            }
            return Disposables.create()
        }
    }
    
    func checkForExistShopping(cocktailId: String) -> Observable<Bool> {
        let context = presistentContainer.viewContext
        let request = ShoppingCocktailEntity.fetchRequest() as NSFetchRequest<ShoppingCocktailEntity>
        
        return Observable.create { observer in
            do {
                let cocktails = try context.fetch(request)
                observer.onNext(cocktails.contains(where: { $0.id == cocktailId }))
                observer.onCompleted()
            } catch {
                observer.onError(DatabaseError.checkCocktailExistFailed)
            }
            return Disposables.create()
        }
    }
    
    func addNewShoppingCocktail(cocktail: Cocktail) -> Observable<Bool> {
        let context = presistentContainer.viewContext
        
        return Observable.create { observer in
            do {
                ShoppingCocktailEntity(context: context).do {
                    $0.id = cocktail.id
                    $0.name = cocktail.strDrink
                    $0.thumb = cocktail.strDrinkThumb
                    $0.instructions = cocktail.strInstructions
                    $0.ingredients = cocktail.ingredients.map { $0.name } as [NSString]
                    $0.measures = cocktail.ingredients.map { $0.measure } as [NSString]
                }
                try context.save()
                observer.onNext(true)
                observer.onCompleted()
            } catch {
                observer.onError(DatabaseError.addCocktailFailed)
            }
            return Disposables.create()
        }
    }
    
    func deleteShoppingCocktail(cocktailId: String) -> Observable<[Cocktail]> {
        let context = presistentContainer.viewContext
        let request = ShoppingCocktailEntity.fetchRequest() as NSFetchRequest<ShoppingCocktailEntity>
        
        return Observable.create { observer in
            do {
                if let cocktailsEntity = try? context.fetch(request) {
                    if let cocktail = cocktailsEntity.first(where: { $0.id == cocktailId }) {
                        context.delete(cocktail)
                        try context.save()
                    }
                    if let cocktailsEntityAfterDelete = try? context.fetch(request) {
                        observer.onNext(self.entityToShoppingCocktails(entities: cocktailsEntityAfterDelete))
                        observer.onCompleted()
                    }
                }
            } catch {
                observer.onError(DatabaseError.deleteCocktailFailed)
            }
            return Disposables.create()
        }
    }
    
    func deleteShoppingCocktailAt(cocktailId: String) -> Observable<Bool> {
        let context = presistentContainer.viewContext
        let request = ShoppingCocktailEntity.fetchRequest() as NSFetchRequest<ShoppingCocktailEntity>
        
        return Observable.create { observer in
            do {
                if let cocktails = try? context.fetch(request) {
                    for cocktail in cocktails where cocktail.id == cocktailId {
                        context.delete(cocktail)
                        try context.save()
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                }
            } catch {
                observer.onError(DatabaseError.deleteCocktailFailed)
            }
            return Disposables.create()
        }
    }
    
    func fetchAllShoppingCocktail() -> Observable<[Cocktail]> {
        let context = presistentContainer.viewContext
        return Observable.create { observer in
            do {
                let request = ShoppingCocktailEntity.fetchRequest() as NSFetchRequest<ShoppingCocktailEntity>
                let cocktailsEntity = try context.fetch(request)
                
                observer.onNext(self.entityToShoppingCocktails(entities: cocktailsEntity))
                observer.onCompleted()
            } catch {
                observer.onError(DatabaseError.getAllCocktailFailed)
            }
            return Disposables.create()
        }
    }
    
    private func entityToCocktails(entities: [CocktailEntity]) -> [Cocktail] {
        let cocktails = entities.map { cocktail in
            let cocktailModel = Cocktail(
                id: cocktail.id ?? "",
                strDrink: cocktail.strDrink ?? "",
                strCategory: cocktail.strCategory ?? "",
                strAlcoholic: cocktail.strAlcoholic ?? "",
                strGlass: cocktail.strGlass ?? "",
                strInstructions: cocktail.strInstructions ?? "",
                strDrinkThumb: cocktail.strDrinkThumb ?? "",
                ingredients: [])
            return cocktailModel
        }
        return cocktails
    }
    
    private func entityToShoppingCocktails(entities: [ShoppingCocktailEntity]) -> [Cocktail] {
        let cocktails = entities.map { (cocktail) -> Cocktail in
            var ingredients = [Ingredient]()
            if let ingredientNames = cocktail.ingredients, let ingredientMeasures = cocktail.measures {
                ingredients = zip(ingredientNames, ingredientMeasures).map {
                    return Ingredient(name: $0 as String, measure: $1 as String)
                }
            }
            let cocktailModel = Cocktail(
                id: cocktail.id ?? "",
                strDrink: cocktail.name ?? "",
                strCategory: "",
                strAlcoholic: "",
                strGlass: "",
                strInstructions: cocktail.instructions ?? "",
                strDrinkThumb: cocktail.thumb ?? "",
                ingredients: ingredients)
            return cocktailModel
        }
        return cocktails
    }
}
