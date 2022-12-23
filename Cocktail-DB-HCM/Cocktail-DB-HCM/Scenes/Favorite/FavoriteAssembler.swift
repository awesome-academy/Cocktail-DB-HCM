//
//  FavoriteAssembler.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import UIKit

protocol FavoriteAssembler {
    func resolve(navigationController: UINavigationController) -> FavoriteViewController
    func resolve(navigationController: UINavigationController) -> FavoriteViewModel
    func resolve(navigationController: UINavigationController) -> FavoriteNavigatorType
    func resolve() -> FavoriteUseCaseType
}

extension FavoriteAssembler {
    func resolve(navigationController: UINavigationController) -> FavoriteViewController {
        let viewController = FavoriteViewController()
        let viewModel: FavoriteViewModel = resolve(navigationController: navigationController)
        viewController.viewModel = viewModel
        return viewController
    }

    func resolve(navigationController: UINavigationController) -> FavoriteViewModel {
        return FavoriteViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension FavoriteAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> FavoriteNavigatorType {
        return FavoriteNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> FavoriteUseCaseType {
        return FavoriteUseCase(favoritesRepository: FavoritesRepository())
    }
}
