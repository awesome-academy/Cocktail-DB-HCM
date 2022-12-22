//
//  InfoTableViewCell.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 21/12/2022.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift

final class InfoTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var cocktailImageView: UIImageView!
    @IBOutlet private weak var cocktailNameLabel: UILabel!
    @IBOutlet private weak var cocktailAlcoholicLabel: UILabel!
    @IBOutlet private weak var cocktailGlassLabel: UILabel!
    @IBOutlet private weak var cocktailCategoryLabel: UILabel!
    @IBOutlet private weak var backBackgroundView: UIView!
    @IBOutlet private weak var favoriteBackgroundView: UIView!
    @IBOutlet private weak var favoriteImageView: UIImageView!
    @IBOutlet private weak var infoBackgroundView: UIView!
    
    var favortieButtonTapped: ((Bool) -> Void)?
    var backButtonTapped: (() -> Void)?
    
    private var isLiked = false
    private var key: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
        self.selectionStyle = .none
        backBackgroundView.do {
            $0.makeCornerRadius(AppConstants.baseCornerRadius)
        }
        
        favoriteBackgroundView.do {
            $0.makeCornerRadius(AppConstants.baseCornerRadius)
        }

        infoBackgroundView.do {
            $0.makeCornerRadius(AppConstants.baseCornerRadius * 3)
        }
    }
    
    private func configureLikeButton(isLiked: Bool) {
        favoriteImageView.image = isLiked
        ? UIImage(systemName: "heart.fill")
        : UIImage(systemName: "heart")
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        backButtonTapped?()
    }
    
    @IBAction func didTapFavoriteButton(_ sender: Any) {
        favortieButtonTapped?(isLiked)
    }
    
    func configureCell(cocktail: CocktailDetail, likedStatus: Bool) {
        isLiked = likedStatus
        cocktailImageView.loadImageWithUrl(path: cocktail.drinkThumb)
        cocktailNameLabel.text = cocktail.title
        cocktailAlcoholicLabel.text = cocktail.alcoholic
        cocktailGlassLabel.text = cocktail.glass
        cocktailCategoryLabel.text = cocktail.category
        configureLikeButton(isLiked: isLiked)
    }
}
