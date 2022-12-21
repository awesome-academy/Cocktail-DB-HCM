//
//  SearchViewController.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import UIKit
import Then
import RxSwift
import RxCocoa
import NSObject_Rx
import Reusable

final class SearchViewController: UIViewController {
    
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBackgroundView: UIView!
    @IBOutlet private weak var searchAlertLabel: UILabel!
    
    var viewModel: SearchViewModel!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    private func setupView() {
        view.backgroundColor = .black
        navigationController?.navigationBar.isHidden = true
        tableView.do {
            $0.register(cellType: SearchTableViewCell.self)
            $0.separatorInset = UIEdgeInsets(
                top: AppConstants.zeroPadding,
                left: UIScreen.main.bounds.width,
                bottom: AppConstants.zeroPadding,
                right: AppConstants.zeroPadding)
            $0.delegate = self
        }
        
        searchBackgroundView.do {
            $0.makeCornerRadius(AppConstants.baseCornerRadius)
        }
    }
}

extension SearchViewController: Bindable {
    func bindViewModel() {
        let input = SearchViewModel.Input(
            searchBarTrigger: searchTextField.rx.text.orEmpty
                .debounce(.milliseconds(SearchScreenConstants.debounceTime), scheduler: MainScheduler.instance)
                .asDriver(onErrorJustReturn: ""),
            selectCocktailTrigger: tableView.rx.itemSelected.asDriver(onErrorDriveWith: .empty())
        )
        
        let output = viewModel.transform(input: input, disposeBag: disposeBag)
        
        output.cocktails
            .drive(tableView.rx.items(cellIdentifier: SearchTableViewCell.reuseIdentifier,
                                      cellType: SearchTableViewCell.self)) { _, item, cell in
                cell.configure(cocktail: item)
            }
            .disposed(by: rx.disposeBag)

        output.cocktailsDriver.forEach {
            $0
            .drive()
            .disposed(by: rx.disposeBag)
        }
        
        output.notFoundCocktail
            .drive(searchAlertLabel.rx.isHidden)
            .disposed(by: rx.disposeBag)
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SearchScreenConstants.heightTableViewCell
    }
}
