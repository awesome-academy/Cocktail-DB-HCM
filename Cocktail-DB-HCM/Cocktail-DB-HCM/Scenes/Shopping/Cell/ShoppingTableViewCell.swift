//
//  ShoppingTableViewCell.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 23/12/2022.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift
import NSObject_Rx
import Then

final class ShoppingTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var cocktailImagView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var deleteButtonBackgroundView: UIView!
    @IBOutlet private weak var cocktailBackgroundImageView: UIImageView!
    @IBOutlet private weak var nameBackgroundView: UIView!
    @IBOutlet private weak var deleteButton: UIButton!
    
    var removeButtonTapped: ((Cocktail) -> Void)?
    private var cocktail = Cocktail()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
        configureCollectionView()
        configureButtonTap()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.do {
            $0.frame = contentView.frame.inset(by: UIEdgeInsets(
                top: AppConstants.basePadding,
                left: AppConstants.basePadding,
                bottom: AppConstants.basePadding,
                right: AppConstants.basePadding))
        }
    }
    
    private func configureView() {
        self.selectionStyle = .none
        contentView.do {
            $0.makeCornerRadius(AppConstants.baseCornerRadius)
        }
        
        deleteButtonBackgroundView.do {
            $0.makeCornerRadius(AppConstants.baseCornerRadius)
        }
        
        nameBackgroundView.do {
            $0.makeCornerRadius(AppConstants.baseCornerRadius)
        }
    }
    
    private func configureCollectionView() {
        collectionView.do {
            $0.register(cellType: IngredientCollectionViewCell.self)
            $0.dataSource = self
            $0.delegate = self
            configureCollectionViewLayout()
        }
    }
    
    private func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.do {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = AppConstants.basePadding
            $0.minimumInteritemSpacing = AppConstants.zeroPadding
            $0.itemSize = CGSize(
                width: IngredientCellConstants.widthCollectionViewCell,
                height: IngredientCellConstants.heightCollectionViewCell)
            $0.sectionInset = UIEdgeInsets(
                top: AppConstants.zeroPadding,
                left: AppConstants.zeroPadding,
                bottom: AppConstants.zeroPadding,
                right: AppConstants.zeroPadding)
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    private func configureButtonTap() {
        deleteButton.rx.tap.asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.removeButtonTapped?(self.cocktail)
            })
            .disposed(by: rx.disposeBag)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cocktail = Cocktail()
        cocktailImagView.image = nil
        cocktailBackgroundImageView.image = nil
        nameLabel.text = nil
    }
    
    func configureCell(cocktail: Cocktail) {
        self.cocktail = cocktail
        cocktailImagView.loadImageWithUrl(path: cocktail.strDrinkThumb)
        cocktailBackgroundImageView.loadImageWithUrl(path: cocktail.strDrinkThumb)
        nameLabel.text = cocktail.strDrink
    }
}

extension ShoppingTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cocktail.ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                      cellType: IngredientCollectionViewCell.self)
            .then {
                $0.configureCell(ingredient: cocktail.ingredients[indexPath.row])
            }
        return cell
    }
}
