//
//  PosterHomeCollectionViewCell.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 19/12/2022.
//

import UIKit
import Then
import SDWebImage
import Reusable
import SnapKit

final class PosterHomeCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var cocktailCategoryLabel: UILabel!
    @IBOutlet private weak var cocktailNameLabel: UILabel!
    @IBOutlet private weak var cocktailGlassLabel: UILabel!
    @IBOutlet private weak var cocktailImageView: UIImageView!
    @IBOutlet private weak var favoriteBackgroundView: UIView!
    @IBOutlet private weak var favoriteImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        cocktailImageView.do {
            $0.makeCornerRadius(AppConstants.baseCornerRadius)
        }
        
        favoriteBackgroundView.do {
            $0.makeCornerRadius($0.bounds.size.width / 2)
        }
    }
    
    func configure(cocktail: Cocktail) {
        cocktailImageView.loadImageWithUrl(path: cocktail.strDrinkThumb)
        cocktailNameLabel.text = cocktail.strDrink
        cocktailCategoryLabel.text = cocktail.strCategory
        cocktailGlassLabel.text = cocktail.strGlass
    }
}
