//
//  TabbarItems.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import UIKit

enum TabbarItem {
    case home
    case search
    case shopping
    case favorite

    var item: UITabBarItem {
        switch self {
        case .home:
            return UITabBarItem(title: "Home",
                                image: UIImage(named: "icons-home"),
                                selectedImage: UIImage(named: "icons-home-selected"))
        case .search:
            return UITabBarItem(title: "Search",
                                image: UIImage(named: "icons-search"),
                                selectedImage: UIImage(named: "icons-search-selected"))
        case .shopping:
            return UITabBarItem(title: "Shopping List",
                                image: UIImage(named: "icons-shopping"),
                                selectedImage: UIImage(named: "icons-shopping-selected"))
        case .favorite:
            return UITabBarItem(title: "My Favorite",
                                image: UIImage(named: "icons-favorite"),
                                selectedImage: UIImage(named: "icons-favorite-selected"))
        }
    }
}
