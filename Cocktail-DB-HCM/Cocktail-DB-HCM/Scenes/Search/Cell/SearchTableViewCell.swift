//
//  SearchTableViewCell.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 20/12/2022.
//

import UIKit
import Then
import Reusable

final class SearchTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var cocktailNameLabel: UILabel!
    @IBOutlet private weak var cocktailCategoryLabel: UILabel!
    @IBOutlet private weak var cocktailAlcoholicLabel: UILabel!
    @IBOutlet private weak var cocktailGlassLabel: UILabel!
    @IBOutlet private weak var infoBackgroundView: UIView!
    @IBOutlet private weak var categoryBackgroundView: UIView!
    @IBOutlet private weak var favoriteImageView: UIImageView!
    @IBOutlet private weak var favoriteBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        backgroundImageView.do {
            $0.makeCornerRadius(SearchScreenConstants.cornerRadiusCellValue)
        }
        
        infoBackgroundView.do {
            $0.makeCornerRadius(SearchScreenConstants.cornerRadiusCellValue)
        }
        
        categoryBackgroundView.do {
            $0.makeCornerRadius(AppConstants.baseCornerRadius)
        }
        
        favoriteBackgroundView.do {
            $0.makeCornerRadius($0.bounds.size.width / 2)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cocktailNameLabel.text = nil
        cocktailCategoryLabel.text = nil
        cocktailAlcoholicLabel.text = nil
        cocktailGlassLabel.text = nil
        backgroundImageView.image = nil
    }
    
    func configure(cocktail: Cocktail) {
        cocktailNameLabel.text = cocktail.strDrink
        cocktailCategoryLabel.text = cocktail.strCategory
        cocktailAlcoholicLabel.text = cocktail.strAlcoholic
        cocktailGlassLabel.text = cocktail.strGlass
        backgroundImageView.loadImageWithUrl(path: cocktail.strDrinkThumb)
    }
}
