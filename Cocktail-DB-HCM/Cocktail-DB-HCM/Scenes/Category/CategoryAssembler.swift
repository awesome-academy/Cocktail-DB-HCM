//
//  CategoryAssembler.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 27/12/2022.
//

import UIKit

protocol CategoryAssembler {
    func resolve(navigationController: UINavigationController, category: CocktailCategory) -> CategoryViewController
    func resolve(navigationController: UINavigationController, category: CocktailCategory) -> CategoryViewModel
    func resolve(navigationController: UINavigationController) -> CategoryNavigatorType
    func resolve() -> CategoryUseCaseType
}

extension CategoryAssembler {
    func resolve(navigationController: UINavigationController, category: CocktailCategory) -> CategoryViewController {
        let viewController = CategoryViewController()
        let viewModel: CategoryViewModel = resolve(navigationController: navigationController, category: category)
        viewController.viewModel = viewModel
        return viewController
    }

    func resolve(navigationController: UINavigationController, category: CocktailCategory) -> CategoryViewModel {
        return CategoryViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve(),
            category: category)
    }
}

extension CategoryAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> CategoryNavigatorType {
        return CategoryNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> CategoryUseCaseType {
        return CategoryUseCase(cocktailsRepository: CocktailRepository())
    }
}
