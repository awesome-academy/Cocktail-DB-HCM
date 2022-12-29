//
//  HomeViewController.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import UIKit
import Then
import RxCocoa
import RxSwift
import Reusable
import NSObject_Rx
import RxDataSources

final class HomeViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    typealias DataSource = RxTableViewSectionedReloadDataSource<CocktailsSection>
    
    var viewModel: HomeViewModel!
    var disposeBag = DisposeBag()
    
    private var dataSource: DataSource!
    private let selectCocktailTrigger = PublishSubject<Cocktail>()
    private let selectCategoryTrigger = PublishSubject<CocktailCategory>()
    private let reloadDataTrigger = PublishSubject<Void>()
    private var isLoading = true

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .black
        navigationController?.navigationBar.isHidden = true
        tableView.do {
            $0.register(cellType: HomeTableViewCell.self)
            $0.tableFooterView = UIView(frame: .zero)
            $0.tableHeaderView = UIView(frame: .zero)
            $0.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
            $0.delegate = self
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0
        ? HomeScreenConstants.heightTableViewPosterCell
        : HomeScreenConstants.heightTableViewCell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let offsetConditionForReload = PageViewSetup.offsetConditionForReload
        
        if position < offsetConditionForReload && !isLoading {
            reloadDataTrigger.onNext(())
        }
    }
}

extension HomeViewController {
    private var configureCell: DataSource.ConfigureCell {
        return { (dataSource, tableView, indexPath, _) in
            let cell = tableView.dequeueReusableCell(for: indexPath,
                                                     cellType: HomeTableViewCell.self)
            var model: CocktailSession
            self.isLoading = false
            
            switch dataSource[indexPath] {
            case .popular(let cocktailSession):
                model = cocktailSession
            case .latest(let cocktailSession):
                model = cocktailSession
            case .random(let cocktailSession):
                model = cocktailSession
            }
            
            cell.selectionStyle = .none
            cell.onItemCocktailTapped = {
                self.selectCocktailTrigger.onNext($0)
            }
            cell.onCocktailsCategoryTapped = {
                self.selectCategoryTrigger.onNext($0)
            }
            cell.configure(model: model)
            return cell
        }
    }
}

extension HomeViewController: Bindable {
    func bindViewModel() {
        
        let loadTrigger = Driver.just(())
        loadTrigger
            .drive(onNext: {_ in
                self.isLoading = true
            })
            .disposed(by: rx.disposeBag)
        
        let reloadTrigger = reloadDataTrigger.asDriver(onErrorJustReturn: ())
        
        reloadTrigger
            .drive(onNext: {_ in
                self.isLoading = true
            })
            .disposed(by: rx.disposeBag)
        
        let input = HomeViewModel.Input(
            loadTrigger: Driver.merge(loadTrigger, reloadTrigger),
            selectCocktailTrigger: selectCocktailTrigger.asDriver(onErrorJustReturn: Cocktail()),
            selectCategoryTrigger: selectCategoryTrigger.asDriver(onErrorJustReturn: .none)
        )
        
        let output = viewModel.transform(input: input, disposeBag: disposeBag)
        dataSource = DataSource(configureCell: configureCell)
        
        output.cocktails
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        output.voidDrivers.forEach {
            $0
                .drive()
                .disposed(by: rx.disposeBag)
        }
        
        output.isLoadingData
            .drive(onNext: { [weak self] isLoading in
                self?.handleIndicator(isLoading ? .show : .hide)
            })
            .disposed(by: rx.disposeBag)
    }
}
