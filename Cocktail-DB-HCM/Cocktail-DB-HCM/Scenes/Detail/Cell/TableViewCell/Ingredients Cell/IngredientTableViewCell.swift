//
//  IngredientTableViewCell.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 21/12/2022.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift
import NSObject_Rx

final class IngredientTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var ingredientNameLabel: UILabel!
    @IBOutlet private weak var ingredientAmountLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var ingredients = [Ingredient]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
        configureCollectionView()
    }
    
    private func configureView() {
        self.selectionStyle = .none
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
    
    func configureCell(ingredients: [Ingredient]) {
        self.ingredients = ingredients
        ingredientAmountLabel.text = "\(ingredients.count) items"
    }
}

extension IngredientTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                      cellType: IngredientCollectionViewCell.self)
        cell.isHidden = ingredients.isEmpty
        cell.configureCell(ingredient: ingredients[indexPath.row])
        return cell
    }
}
