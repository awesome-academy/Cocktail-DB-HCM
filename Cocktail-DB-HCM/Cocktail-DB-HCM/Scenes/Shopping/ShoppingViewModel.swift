//
//  ShoppingViewModel.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

struct ShoppingViewModel {
    let navigator: ShoppingNavigatorType
    let useCase: ShoppingUseCaseType
    let dataSource = BehaviorRelay<[Cocktail]>(value: [Cocktail]())
}

extension ShoppingViewModel: ViewModelType {

    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let deleteTrigger: Driver<Cocktail>
    }
    
    struct Output {
        let loadData: Driver<Void>
        let reloadData: Driver<Void>
        let cocktail: Driver<[Cocktail]>
        let deleted: Driver<[Cocktail]>
    }
    
    func transform(input: Input, disposeBag: RxSwift.DisposeBag) -> Output {
        
        let loadData = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.getShoppingCocktails()
                    .asDriver(onErrorJustReturn: [])
            }
            .do(onNext: dataSource.accept(_:))
            .map { _ in }
        
        let reloadData = input.reloadTrigger
            .flatMapLatest { _ in
                return self.useCase.getShoppingCocktails()
                    .asDriver(onErrorJustReturn: [])
            }
            .do(onNext: dataSource.accept(_:))
            .map { _ in }
        
        let deleted = input.deleteTrigger
            .flatMapLatest { cocktail in
                return useCase.deleteShoppingCocktailAt(cocktailId: cocktail.id)
                    .asDriver(onErrorJustReturn: [])
            }
            .do(onNext: dataSource.accept(_:))
    
        return Output(loadData: loadData,
                      reloadData: reloadData,
                      cocktail: dataSource.asDriver(),
                      deleted: deleted)
    }
}
