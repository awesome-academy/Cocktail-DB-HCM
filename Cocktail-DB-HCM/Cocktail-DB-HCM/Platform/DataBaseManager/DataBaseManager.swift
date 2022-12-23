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
                        observer.onNext(false)
                        observer.onCompleted()
                    }
                }
            } catch {
                observer.onError(DatabaseError.deleteCocktailFailed)
            }
            return Disposables.create()
        }
    }
    
    private func entityToCocktails(entities: [CocktailEntity]) -> [Cocktail] {
        let cocktails = entities.map { (cocktail) -> Cocktail in
            return Cocktail(
                id: cocktail.id ?? "",
                strDrink: cocktail.strDrink ?? "",
                strCategory: cocktail.strCategory ?? "",
                strAlcoholic: cocktail.strAlcoholic ?? "",
                strGlass: cocktail.strGlass ?? "",
                strInstructions: cocktail.strInstructions ?? "",
                strDrinkThumb: cocktail.strDrinkThumb ?? "")
        }
        return cocktails
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
}
