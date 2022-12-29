//
//  HomeNavigator.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import UIKit

protocol HomeNavigatorType {
    func toMain()
    func toDetailScreen(cocktail: Cocktail)
    func toCocktailsCategoryScreen(category: CocktailCategory)
}

struct HomeNavigator: HomeNavigatorType {
    
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController

    func toMain() {
    }
    
    func toDetailScreen(cocktail: Cocktail) {
        let vc: DetailViewController = assembler.resolve(navigationController: navigationController, cocktail: cocktail)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func toCocktailsCategoryScreen(category: CocktailCategory) {
        let vc: CategoryViewController = assembler.resolve(navigationController: navigationController,
                                                           category: category)
        navigationController.pushViewController(vc, animated: false)
    }
}
