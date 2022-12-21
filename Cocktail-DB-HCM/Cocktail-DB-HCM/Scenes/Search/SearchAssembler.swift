//
//  SearchAssembler.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import UIKit

protocol SearchAssembler {
    func resolve(navigationController: UINavigationController) -> SearchViewController
    func resolve(navigationController: UINavigationController) -> SearchViewModel
    func resolve(navigationController: UINavigationController) -> SearchNavigatorType
    func resolve() -> SearchUseCaseType
}

extension SearchAssembler {
    func resolve(navigationController: UINavigationController) -> SearchViewController {
        let viewController = SearchViewController()
        let viewModel: SearchViewModel = resolve(navigationController: navigationController)
        viewController.viewModel = viewModel
        return viewController
    }

    func resolve(navigationController: UINavigationController) -> SearchViewModel {
        return SearchViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension SearchAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> SearchNavigatorType {
        return SearchNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> SearchUseCaseType {
        return SearchUseCase(cocktailsRepository: CocktailRepository())
    }
}
