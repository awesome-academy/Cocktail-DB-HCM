//
//  TabbarNavigator.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import UIKit

protocol TabbarNavigatorType {
    func loadHome(navigationController: UINavigationController)
    func loadSearch(navigationController: UINavigationController)
    func loadShopping(navigationController: UINavigationController)
    func loadFavorite(navigationController: UINavigationController)
}

struct TabbarNavigator: TabbarNavigatorType {

    unowned let assembler: Assembler
    unowned let tabbarController: TabbarViewController

    func loadHome(navigationController: UINavigationController) {
        let vc: HomeViewController = assembler.resolve(navigationController: navigationController)
        navigationController.pushViewController(vc, animated: false)
    }

    func loadSearch(navigationController: UINavigationController) {
        let vc: SearchViewController = assembler.resolve(navigationController: navigationController)
        navigationController.pushViewController(vc, animated: false)
    }

    func loadShopping(navigationController: UINavigationController) {
        let vc: ShoppingViewController = assembler.resolve(navigationController: navigationController)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func loadFavorite(navigationController: UINavigationController) {
        let vc: FavoriteViewController = assembler.resolve(navigationController: navigationController)
        navigationController.pushViewController(vc, animated: false)
    }
}
