//
//  FavoriteViewController.swift
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

final class FavoriteViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let cocktailWillRemove = PublishSubject<Cocktail>()
    private let loadDataTrigger = PublishSubject<Void>()
    
    var viewModel: FavoriteViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigationBar()
        configureCollectionView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDataTrigger.onNext(())
    }
    
    private func configureView() {
        view.backgroundColor = .black
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureCollectionView() {
        collectionView.do {
            $0.register(cellType: FavoriteCollectionViewCell.self)
            $0.contentInset = UIEdgeInsets(
                top: AppConstants.zeroPadding,
                left: AppConstants.basePadding,
                bottom: AppConstants.zeroPadding,
                right: AppConstants.basePadding)
        }
        setupLayout()
    }
    
    private func setupLayout() {
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .vertical
            $0.itemSize = CGSize(
                width: Double(view.bounds.width / 2) - AppConstants.basePadding * 2,
                height: FavoriteCollectionCell.heightCollectionViewCell)
            $0.minimumLineSpacing = AppConstants.basePadding
        }
        collectionView.collectionViewLayout = layout
    }
}

extension FavoriteViewController: Bindable {
    
    func bindViewModel() {
        let input = FavoriteViewModel.Input(loadTrigger: Driver.just(()),
                                            selectTrigger: collectionView.rx.itemSelected
            .asDriver(),
                                            deleteTrigger: cocktailWillRemove
            .asDriver(onErrorDriveWith: .empty()))
        let output = viewModel.transform(input: input, disposeBag: rx.disposeBag)
        
        output.loadData
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.cocktail
            .drive(collectionView.rx.items) { [weak self] (collectionView, index, cocktail) in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                              cellType: FavoriteCollectionViewCell.self)
                cell.do {
                    $0.removeButtonTapped = { self?.cocktailWillRemove.onNext($0) }
                    $0.configureCell(cocktail: cocktail)
                }
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        output.selected
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.deleted
            .drive()
            .disposed(by: rx.disposeBag)
    }
}
