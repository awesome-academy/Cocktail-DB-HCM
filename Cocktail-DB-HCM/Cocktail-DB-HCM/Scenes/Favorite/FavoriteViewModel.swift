//
//  FavoriteViewModel.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

struct FavoriteViewModel {
    let navigator: FavoriteNavigatorType
    let useCase: FavoriteUseCaseType
    let dataSource = BehaviorRelay<[Cocktail]>(value: [Cocktail]())
}

extension FavoriteViewModel: ViewModelType {

    struct Input {
        let loadTrigger: Driver<Void>
        let selectTrigger: Driver<IndexPath>
        let deleteTrigger: Driver<Cocktail>
    }
    
    struct Output {
        let loadData: Driver<Void>
        let cocktail: Driver<[Cocktail]>
        let selected: Driver<Void>
        let deleted: Driver<[Cocktail]>
    }
    
    func transform(input: Input, disposeBag: RxSwift.DisposeBag) -> Output {
        
        let loadData = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.getFavoriteCocktails()
                    .asDriver(onErrorJustReturn: [])
            }
            .do(onNext: dataSource.accept(_:))
            .map { _ in }
        
        let selected = input.selectTrigger
            .withLatestFrom(dataSource.asDriver()) { indexPath, movies in
                return movies[indexPath.row]
            }
            .do(onNext: navigator.toDetailScreen(cocktail:))
            .map { _ in }
        
        let deleted = input.deleteTrigger
            .flatMapLatest { cocktail in
                return useCase.deleteFavoriteCocktailAt(cocktailId: cocktail.id)
                    .asDriver(onErrorJustReturn: [])
            }
            .do(onNext: dataSource.accept(_:))
    
        return Output(loadData: loadData,
                      cocktail: dataSource.asDriver(),
                      selected: selected,
                      deleted: deleted)
    }
}
