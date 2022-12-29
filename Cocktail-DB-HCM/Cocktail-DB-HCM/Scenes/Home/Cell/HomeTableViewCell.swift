//
//  HomeTableViewCell.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 17/12/2022.
//

import UIKit
import Then
import Reusable

final class HomeTableViewCell: UITableViewCell, NibReusable {
    private var model: CocktailSession?
    var onItemCocktailTapped: ((Cocktail) -> Void)?
    var onCocktailsCategoryTapped: ((CocktailCategory) -> Void)?
    
    @IBOutlet private weak var buttonViewAllButton: UIButton!
    @IBOutlet private weak var textCocktailSectionLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        configButtonTap()
    }
    
    private func configureUI() {
        collectionView.do {
            $0.register(cellType: HomeCollectionViewCell.self)
            $0.register(cellType: PosterHomeCollectionViewCell.self)
            $0.contentInset = UIEdgeInsets(
                top: AppConstants.zeroPadding,
                left: AppConstants.zeroPadding,
                bottom: AppConstants.basePadding,
                right: AppConstants.basePadding)
            $0.showsHorizontalScrollIndicator = false
            $0.delegate = self
            $0.dataSource = self
        }
        
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = AppConstants.basePadding
        }
        collectionView.collectionViewLayout = layout
    }
    
    private func configButtonTap() {
        buttonViewAllButton.rx.tap.asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self, let model = self.model else { return }
                self.onCocktailsCategoryTapped?(model.category)
            })
            .disposed(by: rx.disposeBag)
    }

    func configure(model: CocktailSession) {
        self.model = model
        buttonViewAllButton.isHidden = model.category == CocktailCategory.random
        textCocktailSectionLabel.text = model.category.getTitle
    }
}

extension HomeTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let model = model else { return }
        onItemCocktailTapped?(model.cocktails[indexPath.row])
    }
}

extension HomeTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.cocktails.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = model else { return UICollectionViewCell() }
        switch model.category {
        case .random:
            let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                          cellType: HomeCollectionViewCell.self)
                .then {
                    $0.configure(cocktail: model.cocktails[indexPath.row])
                }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                          cellType: PosterHomeCollectionViewCell.self)
                .then {
                    $0.configure(cocktail: model.cocktails[indexPath.row])
                }
            return cell
        }
    }
}

extension HomeTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = model?.category == CocktailCategory.random
        ? contentView.frame.width - AppConstants.basePadding
        : (contentView.frame.width - AppConstants.basePadding * 2) / 2
        let cellHeight = textCocktailSectionLabel.text == CocktailCategory.random.getTitle
        ? HomeScreenConstants.heightCollectionViewPosterCell
        : HomeScreenConstants.heightCollectionViewCell
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
