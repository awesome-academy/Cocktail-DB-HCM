//
//  DetailNavigator.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 21/12/2022.
//

import UIKit

protocol DetailNavigatorType {
    func toMain()
    func toDetail(detail: Cocktail)
}

struct DetailNavigator: DetailNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController

    func toMain() {
    }
    
    func toDetail(detail: Cocktail) {
        let detailNavController = UINavigationController()
        let vc: DetailViewController = assembler.resolve(navigationController: detailNavController, cocktail: detail)
        navigationController.pushViewController(vc, animated: false)
    }
}
