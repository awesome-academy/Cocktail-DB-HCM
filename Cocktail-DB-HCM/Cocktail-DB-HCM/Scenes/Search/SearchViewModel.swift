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
        let loadMoreTrigger: Driver<Void>
    }
    
    struct Output {
        let cocktails: Driver<[Cocktail]>
        let voidDrivers: [Driver<Void>]
        let notFoundCocktail: Driver<Bool>
        let disableLoadMore: Driver<Bool>
        let isLoading: Driver<Bool>
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        
        let currentPage = BehaviorRelay<Int>(value: 1)
        let dataSource = BehaviorRelay<[Cocktail]>(value: [])
        let dataSourceToShow = BehaviorRelay<[Cocktail]>(value: [])
        let handleQuery = BehaviorRelay<String>(value: "")
        let notFoundCocktail = BehaviorRelay<Bool>(value: true)
        let disableLoadMore = BehaviorRelay<Bool>(value: true)
        let isLoading = BehaviorRelay<Bool>(value: false)
        
        input.searchBarTrigger
            .map { $0.replacingOccurrences(of: " ", with: "%20") }
            .do(onNext: handleQuery.accept(_:))
            .flatMapLatest { query in
                isLoading.accept(true)
                return useCase.getCocktailsByName(query: query)
                    .asDriver(onErrorJustReturn: [])
                    .do { _ in
                        isLoading.accept(false)
                    }
            }
            .drive(onNext: {
                dataSource.accept($0)
                dataSourceToShow.accept(Array($0.prefix(PageViewSetup.numberOfItemPerPage)))
                disableLoadMore.accept($0.count <= PageViewSetup.numberOfItemPerPage)
                currentPage.accept(1)
                notFoundCocktail.accept(!($0.isEmpty && !handleQuery.value.isEmpty))
            })
            .disposed(by: disposeBag)
        
        input.loadMoreTrigger
            .drive(onNext: {
                let newPage = currentPage.value + 1
                var data = dataSource.value
                let totalRemoveItem = currentPage.value * PageViewSetup.numberOfItemPerPage
                if totalRemoveItem < dataSource.value.count {
                    data.removeFirst(totalRemoveItem)
                    var newData = dataSourceToShow.value
                    newData.append(contentsOf: Array(data.prefix(PageViewSetup.numberOfItemPerPage)))
                    dataSourceToShow.accept(newData)
                    currentPage.accept(newPage)
                    disableLoadMore.accept(dataSourceToShow.value.count >= dataSource.value.count)
                }
            })
            .disposed(by: disposeBag)
        
        let selectedCocktailId = input.selectCocktailTrigger
            .withLatestFrom(dataSource.asDriver()) { (indexPath, cocktails) -> Cocktail in
                return cocktails[indexPath.row]
            }
            .do(onNext: navigator.toDetailScreen(cocktail:))
            .map { _ in }
                
        return Output(cocktails: dataSourceToShow.asDriver(),
                      voidDrivers: [selectedCocktailId],
                      notFoundCocktail: notFoundCocktail.asDriver(),
                      disableLoadMore: disableLoadMore.asDriver(),
                      isLoading: isLoading.asDriver())
    }
}
