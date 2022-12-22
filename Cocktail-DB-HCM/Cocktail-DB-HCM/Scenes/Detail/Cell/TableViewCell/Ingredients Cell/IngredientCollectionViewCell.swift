//
//  IngredientCollectionViewCell.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 21/12/2022.
//

import UIKit
import Reusable

final class IngredientCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var ingredientImageView: UIImageView!
    @IBOutlet private weak var nameIngredientLabel: UILabel!
    @IBOutlet private weak var measureIngredientLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
        ingredientImageView.do {
            $0.makeCornerRadius(AppConstants.baseCornerRadius)
        }
    }
    
    func configureCell(ingredient: Ingredient) {
        let ingredientName = ingredient.name.replacingOccurrences(of: " ", with: "%20")
        let imageURL = CocktailURLs.shared.getIngredientImage(name: ingredientName)
        ingredientImageView.loadImageWithUrl(path: imageURL)
        nameIngredientLabel.text = ingredient.name
        measureIngredientLabel.text = ingredient.measure
    }
}
