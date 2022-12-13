//
//  SearchViewModel.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import RxSwift
import RxCocoa
import UIKit

struct SearchViewModel {
    let navigator: SearchNavigatorType
    let useCase: SearchUseCaseType
}

extension SearchViewModel: ViewModelType {
    struct Input {
    }
    
    struct Output {
    }

    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        return Output()
    }
}
