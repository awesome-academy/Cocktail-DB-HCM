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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        cocktailImageView.do {
            $0.clipsToBounds = true
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 10
        }
    }
    
    func configure(cocktail: Cocktail) {
        cocktailImageView.loadImageWithUrl(path: cocktail.strDrinkThumb)
        cocktailNameLabel.text = cocktail.strDrink
        cocktailCategoryLabel.text = cocktail.strCategory
        cocktailGlassLabel.text = cocktail.strGlass
    }
}
