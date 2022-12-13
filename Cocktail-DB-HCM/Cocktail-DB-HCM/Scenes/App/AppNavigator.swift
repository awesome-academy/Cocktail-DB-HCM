//
//  AppNavigator.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import UIKit

protocol AppNavigatorType {
    func toMain()
}

struct AppNavigator: AppNavigatorType {
    unowned let assembler: Assembler
    unowned let window: UIWindow

    func toMain() {
        let nav = UINavigationController()
        let tabbar: TabbarViewController = assembler.resolve(navigationController: nav)
        window.rootViewController = tabbar
        window.makeKeyAndVisible()
    }
}
