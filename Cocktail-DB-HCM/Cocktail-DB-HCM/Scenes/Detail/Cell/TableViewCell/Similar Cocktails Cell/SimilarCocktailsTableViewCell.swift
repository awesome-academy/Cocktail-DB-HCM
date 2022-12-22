//
//  SimilarCocktailsTableViewCell.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 21/12/2022.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift
import NSObject_Rx

final class SimilarCocktailsTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var similarMovieTapped: ((Cocktail) -> Void)?
    
    private var cocktails = [Cocktail]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()
        configureView()
    }
    
    private func configureView() {
        self.selectionStyle = .none
    }
    
    private func configureCollectionView() {
        collectionView.do {
            $0.register(cellType: PosterHomeCollectionViewCell.self)
            $0.dataSource = self
            $0.delegate = self
            configureLayoutCollectionView()
        }
    }
    
    private func configureLayoutCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.do {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = AppConstants.basePadding
            $0.minimumInteritemSpacing = AppConstants.zeroPadding
            $0.itemSize = CGSize(
                width: (contentView.frame.width - AppConstants.basePadding * 2) / 2,
                height: SimilarCellConstants.heightCollectionViewCell)
            $0.sectionInset = UIEdgeInsets(
                top: AppConstants.zeroPadding,
                left: AppConstants.zeroPadding,
                bottom: AppConstants.zeroPadding,
                right: AppConstants.zeroPadding)
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func configureCell(cocktails: [Cocktail]) {
        self.cocktails = cocktails
    }
}

extension SimilarCocktailsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cocktails.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                      cellType: PosterHomeCollectionViewCell.self)
        cell.configure(cocktail: cocktails[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        similarMovieTapped?(cocktails[indexPath.row])
    }
}
