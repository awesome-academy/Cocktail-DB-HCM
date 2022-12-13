//
//  HomeViewController.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import UIKit
import RxSwift

final class HomeViewController: UIViewController {

    var viewModel: HomeViewModel!
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HomeViewController: Bindable {
    func bindViewModel() {
    }
}
