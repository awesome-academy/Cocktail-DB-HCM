//
//  UIImageView+.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 17/12/2022.
//

import UIKit
import SDWebImage

extension UIImageView {
    func loadImageWithUrl(path: String) {
        self.image = UIImage(named: "imageNotFound")
        if !path.isEmpty {
            self.sd_setImage(with: URL(string: path))
        }
    }
}
