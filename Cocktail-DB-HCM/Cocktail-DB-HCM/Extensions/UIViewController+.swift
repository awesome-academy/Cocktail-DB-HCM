//
//  UIViewController+.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 27/12/2022.
//

import Foundation
import UIKit

enum IndicatorType {
    case show
    case hide
}

extension UIViewController {
    static let activityIndicator = UIActivityIndicatorView(style: .large)
    
    func showAlert(title: String, messageError: String) {
        let alert = UIAlertController(title: title,
                                      message: messageError,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleIndicator(_ type: IndicatorType) {
        type == .show
        ? UIViewController.activityIndicator.startAnimating()
        : UIViewController.activityIndicator.stopAnimating()
        configActivityIndicator(type)
        view.isUserInteractionEnabled = type == .hide
     }
    
    func configActivityIndicator(_ type: IndicatorType) {
        switch type {
        case .show:
            view.addSubview(UIViewController.activityIndicator)
            UIViewController.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            UIViewController.activityIndicator.hidesWhenStopped = true
            UIViewController.activityIndicator.color = UIColor.white
            let horizontalConstraint = NSLayoutConstraint(item: UIViewController.activityIndicator,
                                                          attribute: .centerX,
                                                          relatedBy: .equal,
                                                          toItem: view,
                                                          attribute: .centerX,
                                                          multiplier: 1,
                                                          constant: 0)
            view.addConstraint(horizontalConstraint)
            let verticalConstraint = NSLayoutConstraint(item: UIViewController.activityIndicator,
                                                        attribute: .centerY,
                                                        relatedBy: .equal,
                                                        toItem: view,
                                                        attribute: .centerY,
                                                        multiplier: 1,
                                                        constant: 0)
            view.addConstraint(verticalConstraint)
        case .hide:
            UIViewController.activityIndicator.removeFromSuperview()
        }
    }
}

