//
//  DetailAssembler.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 21/12/2022.
//

import UIKit

protocol DetailAssembler {
    func resolve(navigationController: UINavigationController, cocktail: Cocktail) -> DetailViewController
    func resolve(navigationController: UINavigationController, cocktail: Cocktail) -> DetailViewModel
    func resolve(navigationController: UINavigationController) -> DetailNavigatorType
    func resolve() -> DetailUseCaseType
}

extension DetailAssembler {
    func resolve(navigationController: UINavigationController, cocktail: Cocktail) -> DetailViewController {
        let viewController = DetailViewController()
        let viewModel: DetailViewModel = resolve(navigationController: navigationController, cocktail: cocktail)
        viewController.viewModel = viewModel
        return viewController
    }

    func resolve(navigationController: UINavigationController, cocktail: Cocktail) -> DetailViewModel {
        return DetailViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve(),
            cocktail: cocktail)
    }
}

extension DetailAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> DetailNavigatorType {
        return DetailNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> DetailUseCaseType {
        return DetailUseCase(cocktailRepository: CocktailRepository(), favoritesRepository: FavoritesRepository())
    }
}
