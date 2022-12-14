//
//  FavoriteNavigator.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import UIKit

protocol FavoriteNavigatorType {
    func toMain()
    func toDetailScreen(cocktail: Cocktail)
}

struct FavoriteNavigator: FavoriteNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController

    func toMain() {
    }
    
    func toDetailScreen(cocktail: Cocktail) {
        let vc: DetailViewController = assembler.resolve(navigationController: navigationController, cocktail: cocktail)
        navigationController.pushViewController(vc, animated: true)
    }
}

