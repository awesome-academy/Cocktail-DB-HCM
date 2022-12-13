//
//  FavoriteNavigator.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import UIKit

protocol FavoriteNavigatorType {
    func toMain()
}

struct FavoriteNavigator: FavoriteNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController

    func toMain() {
    }
}

