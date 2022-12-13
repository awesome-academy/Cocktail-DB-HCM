//
//  ShoppingViewController.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import UIKit
import RxSwift

final class ShoppingViewController: UIViewController {

    var viewModel: ShoppingViewModel!
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ShoppingViewController: Bindable {
    func bindViewModel() {
    }
}
