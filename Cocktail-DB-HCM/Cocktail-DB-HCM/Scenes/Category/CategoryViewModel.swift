//
//  CategoryViewModel.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 27/12/2022.
//

import UIKit
import RxSwift
import RxCocoa

struct CategoryViewModel {
    let navigator: CategoryNavigatorType
    let useCase: CategoryUseCaseType
    let category: CocktailCategory
    
    struct Input {
        let loadTrigger: Driver<Void>
        let selectCocktailTrigger: Driver<IndexPath>
        let loadMoreTrigger: Driver<Void>
    }
    
    struct Output {
        let title: Driver<String>
        let voidDrivers: [Driver<Void>]
        let cocktails: Driver<[Cocktail]>
        let disableLoadMore: Driver<Bool>
        let isLoading: Driver<Bool>
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        
        let currentPage = BehaviorRelay<Int>(value: 1)
        let dataSource = BehaviorRelay<[Cocktail]>(value: [])
        let dataSourceToShow = BehaviorRelay<[Cocktail]>(value: [])
        let disableLoadMore = BehaviorRelay<Bool>(value: true)
        let isLoading = BehaviorRelay<Bool>(value: false)
        
        let title = input.loadTrigger
            .map { category.getTitle }
        
        input.loadTrigger
            .flatMapLatest { _ in
                isLoading.accept(true)
                return useCase.getListCocktails(category: category)
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
                
        return Output(title: title,
                      voidDrivers: [selectedCocktailId],
                      cocktails: dataSourceToShow.asDriver(),
                      disableLoadMore: disableLoadMore.asDriver(),
                      isLoading: isLoading.asDriver())
    }
}
