//
//  SearchViewModel.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import UIKit
import RxSwift
import RxCocoa

struct SearchViewModel {
    let navigator: SearchNavigatorType
    let useCase: SearchUseCaseType
    
    struct Input {
        let searchBarTrigger: Driver<String>
        let selectCocktailTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let cocktails: Driver<[Cocktail]>
        let cocktailsDriver: [Driver<[Cocktail]>]
        let notFoundCocktail: Driver<Bool>
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let dataSource = BehaviorRelay<[Cocktail]>(value: [])
        let handleQuery = BehaviorRelay<String>(value: "")
        let notFoundCocktail = BehaviorRelay<Bool>(value: true)
        
        let cocktailsSearched = input.searchBarTrigger
            .map { $0.replacingOccurrences(of: " ", with: "%20") }
            .do(onNext: handleQuery.accept(_:))
            .flatMapLatest { query in
                return useCase.getCocktailsByName(query: query)
                    .asDriver(onErrorJustReturn: [])
            }
            .do(onNext: {
                dataSource.accept($0)
                notFoundCocktail.accept(!($0.isEmpty && !handleQuery.value.isEmpty))
            })
        
        let cocktailsDriver = [cocktailsSearched]
                
        return Output(cocktails: dataSource.asDriver(),
                      cocktailsDriver: cocktailsDriver,
                      notFoundCocktail: notFoundCocktail.asDriver())
    }
}
