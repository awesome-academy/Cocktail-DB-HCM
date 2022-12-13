//
//  FavoriteViewController.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import UIKit
import RxSwift

final class FavoriteViewController: UIViewController {

    var viewModel: FavoriteViewModel!
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FavoriteViewController: Bindable {
    func bindViewModel() {
    }
}
