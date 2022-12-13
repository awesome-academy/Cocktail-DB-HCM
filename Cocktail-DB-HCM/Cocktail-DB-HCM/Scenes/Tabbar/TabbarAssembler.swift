//
//  TabbarAssembler.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import UIKit

protocol TabbarAssembler {
    func resolve(navigationController: UINavigationController) -> TabbarViewController
    func resolve(navigationController: UINavigationController) -> TabbarNavigatorType
}

extension TabbarAssembler {
    func resolve(navigationController: UINavigationController) -> TabbarViewController {
        let tabbarVC = TabbarViewController()
        tabbarVC.tabBar.tintColor = UIColor.MyTheme.primary
        tabbarVC.tabBar.backgroundColor = .white
        
        let navigator: TabbarNavigatorType = resolve(navigationController: navigationController)
        let homeNavController = UINavigationController()
        homeNavController.tabBarItem = TabbarItem.home.item
        navigator.loadHome(navigationController: homeNavController)

        let searchNavController = UINavigationController()
        searchNavController.tabBarItem = TabbarItem.search.item
        navigator.loadSearch(navigationController: searchNavController)

        let shoppingNavController = UINavigationController()
        shoppingNavController.tabBarItem = TabbarItem.shopping.item
        navigator.loadShopping(navigationController: shoppingNavController)
        
        let favoriteNavController = UINavigationController()
        favoriteNavController.tabBarItem = TabbarItem.favorite.item
        navigator.loadFavorite(navigationController: favoriteNavController)

        tabbarVC.viewControllers = [homeNavController,
                                    searchNavController,
                                    shoppingNavController,
                                    favoriteNavController]
        return tabbarVC
    }
}

extension TabbarAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> TabbarNavigatorType {
        return TabbarNavigator(assembler: self, tabbarController: TabbarViewController())
    }
}
