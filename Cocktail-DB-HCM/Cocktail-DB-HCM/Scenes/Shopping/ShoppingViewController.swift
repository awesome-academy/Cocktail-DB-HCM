//
//  ShoppingViewController.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift
import Then
import NSObject_Rx

final class ShoppingViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private let cocktailWillRemove = PublishSubject<Cocktail>()
    private let loadDataTrigger = PublishSubject<Void>()
    private let reloadDataTrigger = PublishSubject<Void>()
    
    var viewModel: ShoppingViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigationBar()
        configureTableView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadDataTrigger.onNext(())
    }
    
    private func configureView() {
        view.backgroundColor = .black
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureTableView() {
        tableView.do {
            $0.register(cellType: ShoppingTableViewCell.self)
            $0.separatorStyle = .none
            $0.selectionFollowsFocus = false
        }
    }
}

extension ShoppingViewController: Bindable {
    
    func bindViewModel() {
        let input = ShoppingViewModel.Input(loadTrigger: Driver.just(()),
                                            reloadTrigger: reloadDataTrigger.asDriver(onErrorJustReturn: ()),
                                            deleteTrigger: cocktailWillRemove.asDriver(onErrorDriveWith: .empty()))
        let output = viewModel.transform(input: input, disposeBag: rx.disposeBag)
        
        output.loadData
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.reloadData
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.cocktail
            .drive(tableView.rx.items) { [weak self] (tableView, index, cocktail) in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(for: indexPath,
                                                         cellType: ShoppingTableViewCell.self)
                cell.do {
                    $0.removeButtonTapped = { self?.cocktailWillRemove.onNext($0) }
                    $0.configureCell(cocktail: cocktail)
                }
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        output.deleted
            .drive()
            .disposed(by: rx.disposeBag)
    }
}
