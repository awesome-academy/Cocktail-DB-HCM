//
//  UIView+.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 21/12/2022.
//

import Foundation
import UIKit

extension UIView {
    func makeCornerRadius(_ value: Double) {
        clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = value
    }
}
