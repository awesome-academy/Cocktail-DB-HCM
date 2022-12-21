//
//  HomeCollectionViewCell.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 18/12/2022.
//

import UIKit
import Then
import SDWebImage
import Reusable
import SnapKit

final class HomeCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var infoBackgroundView: UIView!
    @IBOutlet private weak var cocktailTitleLabel: UILabel!
    @IBOutlet private weak var cocktailCategoryLabel: UILabel!
    @IBOutlet private weak var cocktailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        cocktailImageView.do {
            $0.makeCornerRadius(AppConstants.baseCornerRadius)
        }
    }

    func configure(cocktail: Cocktail) {
        cocktailImageView.loadImageWithUrl(path: cocktail.strDrinkThumb)
        cocktailTitleLabel.text = cocktail.strDrink
        cocktailCategoryLabel.text = cocktail.strCategory
    }
}

