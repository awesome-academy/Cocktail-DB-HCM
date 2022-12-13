//
//  SearchViewController.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import UIKit
import RxSwift

final class SearchViewController: UIViewController {

    var viewModel: SearchViewModel!
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SearchViewController: Bindable {
    func bindViewModel() {
    }
}
