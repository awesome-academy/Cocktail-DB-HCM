//
//  DetailViewModel.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 21/12/2022.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

struct DetailViewModel {
    
    let navigator: DetailNavigatorType
    let useCase: DetailUseCaseType
    let cocktail: Cocktail
    
    struct Input {
        let loadTrigger: Driver<Void>
        let selectedSimilarTrigger: Driver<Cocktail>
    }
    
    struct Output {
        let title: Driver<String>
        let detailAndFavoriteStatus: Driver<[DetailsSectionModel]>
        let selectedSimilar: Driver<Void>
        let voidDrivers: [Driver<Void>]
    }
    
    func transform(_ input: Input) -> Output {
        
        let likedStatus = BehaviorRelay<Bool>(value: false)
        
        let title = input.loadTrigger
            .map { cocktail.strDrink }
        
        let detail = input.loadTrigger
            .flatMapLatest { _ in
                return useCase.getCocktailDetail(cocktailId: cocktail.id)
                    .asDriver(onErrorJustReturn: CocktailDetail())
            }
        print("CocktailID: \(cocktail)")
        
        let similar = input.loadTrigger
            .flatMapLatest { _ in
                return useCase.getListCocktails(category: cocktail.strCategory)
                    .asDriver(onErrorJustReturn: [])
                    .map {
                        return SimilarCocktailSession(category: cocktail.strCategory, cocktails: $0)
                    }
            }

        let detailsAndLiked = Driver.combineLatest(detail, likedStatus.asDriver(), similar)
            .map { cocktailDetail, isLiked, similar -> [DetailsSectionModel] in
                return [.detail(items: [
                    .info(model: cocktailDetail,
                          likedStatus: isLiked),
                    .description(model: cocktailDetail.instruction),
                    .ingredient(model: cocktailDetail.ingredients),
                    .similar(model: similar.cocktails)
                ])]
            }
            .asDriver(onErrorJustReturn: [DetailsSectionModel]())
        
        let selectedSimilar = input.selectedSimilarTrigger
            .do(onNext: navigator.toDetail(detail:))
            .map { _ in }

        return Output(title: title,
                      detailAndFavoriteStatus: detailsAndLiked,
                      selectedSimilar: selectedSimilar,
                      voidDrivers: [])
    }
}
