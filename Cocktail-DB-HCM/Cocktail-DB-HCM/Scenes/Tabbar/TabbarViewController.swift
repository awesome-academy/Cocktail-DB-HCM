//
//  TabbarViewController.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import UIKit

final class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        tabBar.do {
            $0.tintColor = .yellow
            $0.unselectedItemTintColor = .lightGray
            $0.backgroundColor = .black
            $0.backgroundImage = UIImage()
        }
    }
}
