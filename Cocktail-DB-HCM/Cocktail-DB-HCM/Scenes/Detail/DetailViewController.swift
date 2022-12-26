//
//  DetailViewController.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 21/12/2022.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import RxDataSources
import Reusable

final class DetailViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    typealias DataSource = RxTableViewSectionedReloadDataSource<DetailsSectionModel>
    
    var viewModel: DetailViewModel!

    private let similarCocktail = PublishSubject<Cocktail>()
    private let likeButtonTrigger = PublishSubject<Bool>()
    private let loadTrigger = BehaviorSubject<Void>(value: ())
    private let shoppingButtonTrigger = PublishSubject<Bool>()
    
    private var dataSource: DataSource!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configeTableView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTrigger.onNext(())
    }
    
    private func configeTableView() {
        tableView.separatorStyle = .none
        setupView()
        setupDataSource()
    }
    
    private func setupView() {
        view.backgroundColor = .black
        navigationController?.navigationBar.isHidden = true
        tableView.do {
            $0.register(cellType: InfoTableViewCell.self)
            $0.register(cellType: InstructionsTableViewCell.self)
            $0.register(cellType: IngredientTableViewCell.self)
            $0.register(cellType: SimilarCocktailsTableViewCell.self)
            $0.rx.setDelegate(self)
                .disposed(by: rx.disposeBag)
        }
    }
    
    private func setupDataSource() {
        dataSource = DataSource(configureCell: configureCell)
    }
}

extension DetailViewController: Bindable {
    func bindViewModel() {
        let input = DetailViewModel.Input(
            loadTrigger: loadTrigger.asDriver(onErrorJustReturn: ()),
            selectedSimilarTrigger: similarCocktail.asDriver(onErrorJustReturn: Cocktail()),
            likeTrigger: likeButtonTrigger.asDriver(onErrorJustReturn: false),
            shoppingTrigger: shoppingButtonTrigger.asDriver(onErrorJustReturn: false))
        let output = viewModel.transform(input)
        
        output.title
            .drive(self.rx.title)
            .disposed(by: rx.disposeBag)
        
        output.detailAndFavoriteStatus
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        output.selectedSimilar
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.voidDrivers.forEach {
            $0.drive()
                .disposed(by: rx.disposeBag)
        }
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath] {
        case .info:
            return UITableView.automaticDimension
        case .description:
            return UITableView.automaticDimension
        case .ingredient:
            return DetailTableViewCell.ingredientRowHeight
        case .similar:
            return DetailTableViewCell.similarRowHeight
        }
    }
}

extension DetailViewController {
    private var configureCell: DataSource.ConfigureCell {
        return { [weak self] (dataSource, tableView, indexPath, _) in
            switch dataSource[indexPath] {
            case .info(let model, let isLiked, let isShopping):
                let cell = tableView.dequeueReusableCell(for: indexPath,
                                                         cellType: InfoTableViewCell.self)
                cell.do {
                    $0.shoppingButtonTapped = { self?.shoppingButtonTrigger.onNext($0) }
                    $0.backButtonTapped = { self?.navigationController?.popViewController(animated: true) }
                    $0.favortieButtonTapped = { self?.likeButtonTrigger.onNext($0) }
                    $0.configureCell(cocktail: model, isLiked: isLiked, isShopping: isShopping)
                }
                return cell
            case .description(let model):
                let cell = tableView.dequeueReusableCell(for: indexPath,
                                                         cellType: InstructionsTableViewCell.self)
                cell.showMoreButtonTapped = { self?.tableView.reloadData() }
                cell.configureCell(instructions: model)
                return cell
            case .ingredient(let model):
                let cell = tableView.dequeueReusableCell(for: indexPath,
                                                         cellType: IngredientTableViewCell.self)
                cell.configureCell(ingredients: model)
                return cell
            case .similar(let model):
                let cell = tableView.dequeueReusableCell(for: indexPath,
                                                         cellType: SimilarCocktailsTableViewCell.self)
                cell.similarMovieTapped = { self?.similarCocktail.onNext($0) }
                cell.configureCell(cocktails: model)
                return cell
            }
        }
    }
}
