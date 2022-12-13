//
//  AppViewModel.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import RxSwift
import RxCocoa
import UIKit

struct AppViewModel {
    let navigator: AppNavigatorType
    let useCase: AppUseCaseType
}

extension AppViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }

    struct Output {
    }

    func transform(input: AppViewModel.Input, disposeBag: DisposeBag) -> Output {
        let toMain = input.loadTrigger
            .drive(onNext: navigator.toMain)
            .disposed(by: disposeBag)
        return Output()
    }
}
