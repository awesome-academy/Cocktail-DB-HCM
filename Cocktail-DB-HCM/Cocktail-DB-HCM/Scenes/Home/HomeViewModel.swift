//
//  HomeViewModel.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import RxSwift
import RxCocoa
import UIKit

struct HomeViewModel {
    let navigator: HomeNavigatorType
    let useCase: HomeUseCaseType
}

extension HomeViewModel: ViewModelType {
    struct Input {
    }
    
    struct Output {
    }

    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        return Output()
    }
}
