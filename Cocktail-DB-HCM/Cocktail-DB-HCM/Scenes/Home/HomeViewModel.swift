//
//  HomeViewModel.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

struct HomeViewModel {
    let navigator: HomeNavigatorType
    let useCase: HomeUseCaseType
}

extension HomeViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let selectCocktailTrigger: Driver<Cocktail>
        let selectCategoryTrigger: Driver<CocktailCategory>
    }
    
    struct Output {
        let cocktails: Driver<[CocktailsSection]>
        let voidDrivers: [Driver<Void>]
        var isLoading = false
        var isReloading = false
        var isLoadingMore = false
        var isEmpty = false
        let isLoadingData: Driver<Bool>
    }

    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let isLoading = BehaviorRelay<Bool>(value: false)
        
        let random = input.loadTrigger
            .flatMapLatest { _ in
                isLoading.accept(true)
                return useCase.getListCocktails(category: .random)
                    .asDriver(onErrorJustReturn: [])
                    .map {
                        return CocktailSession(category: .random, cocktails: $0)
                    }
            }
        let popular = input.loadTrigger
            .flatMapLatest { _ in
                isLoading.accept(true)
                return useCase.getListCocktails(category: .popular)
                    .asDriver(onErrorJustReturn: [])
                    .map {
                        return CocktailSession(category: .popular, cocktails: $0)
                    }
            }
        
        let latest = input.loadTrigger
            .flatMapLatest { _ in
                isLoading.accept(true)
                return useCase.getListCocktails(category: .latest)
                    .asDriver(onErrorJustReturn: [])
                    .map {
                        return CocktailSession(category: .latest, cocktails: $0)
                    }
            }
        
        let cocktails = Driver.combineLatest(random, popular, latest)
            .map { random, popular, latest -> [CocktailsSection] in
                isLoading.accept(true)
                return [
                    .cocktails(items: [
                        .random(model: random),
                        .popular(model: popular),
                        .latest(model: latest)
                    ])
                ]
            }
            .asDriver(onErrorJustReturn: [])
            .do { _ in
                isLoading.accept(false)
            }
        
        let selectedCocktailId = input.selectCocktailTrigger
            .do(onNext: navigator.toDetailScreen(cocktail:))
            .map { _ in }
        
        let selectedCocktailCategory = input.selectCategoryTrigger
            .do(onNext: navigator.toCocktailsCategoryScreen(category:))
            .map { _ in }
        
        return Output(cocktails: cocktails,
                      voidDrivers: [selectedCocktailId, selectedCocktailCategory],
                      isLoadingData: isLoading.asDriver())
    }
}
