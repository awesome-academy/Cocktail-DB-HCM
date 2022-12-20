//
//  HomeAssembler.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import UIKit

protocol HomeAssembler {
    func resolve(navigationController: UINavigationController) -> HomeViewController
    func resolve(navigationController: UINavigationController) -> HomeViewModel
    func resolve(navigationController: UINavigationController) -> HomeNavigatorType
    func resolve() -> HomeUseCaseType
}

extension HomeAssembler {
    func resolve(navigationController: UINavigationController) -> HomeViewController {
        let viewController = HomeViewController()
        let viewModel: HomeViewModel = resolve(navigationController: navigationController)
        viewController.viewModel = viewModel
        return viewController
    }

    func resolve(navigationController: UINavigationController) -> HomeViewModel {
        return HomeViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension HomeAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> HomeNavigatorType {
        return HomeNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> HomeUseCaseType {
        return HomeUseCase(cocktailRepository: CocktailRepository())
    }
}
