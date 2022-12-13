//
//  ShoppingNavigator.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import UIKit

protocol ShoppingNavigatorType {
    func toMain()
}

struct ShoppingNavigator: ShoppingNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController

    func toMain() {
    }
}
