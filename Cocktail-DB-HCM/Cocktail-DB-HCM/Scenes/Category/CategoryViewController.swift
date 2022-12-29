//
//  CategoryViewController.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 27/12/2022.
//

import UIKit
import Then
import RxSwift
import RxCocoa
import NSObject_Rx
import Reusable

final class CategoryViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var titleCategoryLabel: UILabel!
    @IBOutlet private weak var backButton: UIButton!
    
    var viewModel: CategoryViewModel!
    var disposeBag = DisposeBag()
    
    private let loadMoreTrigger = PublishSubject<Void>()
    private let reloadDataTrigger = PublishSubject<Void>()
    private var isLoading = true
    private var isDisableLoadMore = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configButtonTap()
        bindViewModel()
    }
    
    private func setupView() {
        view.backgroundColor = .black
        tableView.do {
            $0.register(cellType: SearchTableViewCell.self)
            $0.separatorInset = UIEdgeInsets(
                top: AppConstants.zeroPadding,
                left: UIScreen.main.bounds.width,
                bottom: AppConstants.zeroPadding,
                right: AppConstants.zeroPadding)
            $0.delegate = self
        }
    }
    
    private func configButtonTap() {
        backButton.rx.tap.asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                guard let navigationVC = self.navigationController else { return }
                  navigationVC.popViewController(animated: false)
            })
            .disposed(by: rx.disposeBag)
    }
}

extension CategoryViewController: Bindable {
    func bindViewModel() {
        
        let loadTrigger = Driver.just(())
        
        loadTrigger
            .drive(onNext: {_ in
                self.isLoading = true
            })
            .disposed(by: rx.disposeBag)
        
        let input = CategoryViewModel.Input(
            loadTrigger: Driver.merge(loadTrigger, reloadDataTrigger.asDriver(onErrorJustReturn: ())),
            selectCocktailTrigger: tableView.rx.itemSelected.asDriver(onErrorDriveWith: .empty()),
            loadMoreTrigger: loadMoreTrigger.asDriver(onErrorJustReturn: ())
        )
        
        let output = viewModel.transform(input: input, disposeBag: rx.disposeBag)
        
        output.title
            .drive(titleCategoryLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        output.cocktails
            .drive(tableView.rx.items(cellIdentifier: SearchTableViewCell.reuseIdentifier,
                                      cellType: SearchTableViewCell.self)) { _, item, cell in
                self.isLoading = false
                cell.configure(cocktail: item)
            }
            .disposed(by: rx.disposeBag)
        
        output.voidDrivers.forEach {
            $0
                .drive()
                .disposed(by: rx.disposeBag)
        }
        
        output.disableLoadMore
            .drive(onNext: { isDisableLoadMore in
                self.isDisableLoadMore = isDisableLoadMore
            })
            .disposed(by: rx.disposeBag)
        
        output.isLoading
            .drive(onNext: { isLoading in
                self.tableView.tableHeaderView = isLoading
                ? createSpinner(width: self.view.frame.size.width)
                : nil
            })
            .disposed(by: rx.disposeBag)
    }
}

extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SearchScreenConstants.heightTableViewCell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let offsetConditionForReload = PageViewSetup.offsetConditionForReload
        let lastFrameTableView = (tableView.contentSize.height - scrollView.frame.size.height + 200)
        
        if (position > lastFrameTableView) && !isLoading && !isDisableLoadMore {
            isLoading = true
            loadMoreTrigger.onNext(())
        }
        
        if position < offsetConditionForReload && !isLoading {
            reloadDataTrigger.onNext(())
        }
    }
}
