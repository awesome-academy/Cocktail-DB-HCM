//
//  ShoppingAssembler.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import UIKit

protocol ShoppingAssembler {
    func resolve(navigationController: UINavigationController) -> ShoppingViewController
    func resolve(navigationController: UINavigationController) -> ShoppingViewModel
    func resolve(navigationController: UINavigationController) -> ShoppingNavigatorType
    func resolve() -> ShoppingUseCaseType
}

extension ShoppingAssembler {
    func resolve(navigationController: UINavigationController) -> ShoppingViewController {
        let viewController = ShoppingViewController()
        let viewModel: ShoppingViewModel = resolve(navigationController: navigationController)
        viewController.bindViewModel(to: viewModel)
        return viewController
    }

    func resolve(navigationController: UINavigationController) -> ShoppingViewModel {
        return ShoppingViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension ShoppingAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> ShoppingNavigatorType {
        return ShoppingNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> ShoppingUseCaseType {
        return ShoppingUseCase()
    }
}
