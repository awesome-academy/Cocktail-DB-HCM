//
//  UIColor+.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import UIKit

extension UIColor {
    convenience init(argb: UInt) {
        self.init(
            red: CGFloat((argb & 0x00FF0000) >> 16) / 255.0,
            green: CGFloat((argb & 0x0000FF00) >> 8) / 255.0,
            blue: CGFloat(argb & 0x000000FF) / 255.0,
            alpha: CGFloat((argb & 0xFF000000) >> 24) / 255.0
        )
    }
    
    struct MyTheme {
        static var primary: UIColor { return UIColor(argb: 0xFF439270) }
    }
}
