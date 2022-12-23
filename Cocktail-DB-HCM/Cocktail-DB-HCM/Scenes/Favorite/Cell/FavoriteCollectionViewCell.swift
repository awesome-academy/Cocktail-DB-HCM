//
//  FavoriteCollectionViewCell.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 22/12/2022.
//

import UIKit
import Reusable

final class FavoriteCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var cocktailImagView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var subInfoLabel: UILabel!
    @IBOutlet private weak var removeBackgroundView: UIView!
    @IBOutlet private weak var infoBackgroundView: UIView!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var categoryBackgroundView: UIView!
    
    var removeButtonTapped: ((Cocktail) -> Void)?
    private var cocktail = Cocktail()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        removeBackgroundView.do {
            $0.makeCornerRadius($0.bounds.size.width / 2)
        }
        
        self.do {
            $0.makeCornerRadius(AppConstants.baseCornerRadius)
        }
        
        infoBackgroundView.do {
            $0.makeCornerRadius(AppConstants.baseCornerRadius)
        }
        
        categoryBackgroundView.do {
            $0.makeCornerRadius(AppConstants.baseCornerRadius)
        }
    }

    @IBAction func didTapRemoveCocktail(_ sender: Any) {
        removeButtonTapped?(cocktail)
    }
    
    override func prepareForReuse() {
        self.cocktail = Cocktail()
        cocktailImagView.image = nil
        nameLabel.text = nil
        subInfoLabel.text = nil
        categoryLabel.text = nil
    }
    
    func configureCell(cocktail: Cocktail) {
        self.cocktail = cocktail
        cocktailImagView.loadImageWithUrl(path: cocktail.strDrinkThumb)
        nameLabel.text = cocktail.strDrink
        subInfoLabel.text = cocktail.strGlass
        categoryLabel.text = cocktail.strCategory
    }
}
