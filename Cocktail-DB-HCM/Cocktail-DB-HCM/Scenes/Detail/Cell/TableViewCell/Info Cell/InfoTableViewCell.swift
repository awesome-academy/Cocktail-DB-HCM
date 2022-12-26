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
    @IBOutlet private weak var addToShoppingButton: UIButton!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var backButton: UIButton!
    
    var favortieButtonTapped: ((Bool) -> Void)?
    var backButtonTapped: (() -> Void)?
    var shoppingButtonTapped: ((Bool) -> Void)?
    
    private var isLiked = false
    private var isShopping = false
    private var key: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
        configureButtonTap()
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
        
        addToShoppingButton.do {
            $0.makeCornerRadius(AppConstants.baseCornerRadius)
        }
    }
    
    private func configureButtonTap() {
        addToShoppingButton.rx.tap.asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.shoppingButtonTapped?(self.isShopping)
            })
            .disposed(by: rx.disposeBag)
        
        favoriteButton.rx.tap.asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.favortieButtonTapped?(self.isLiked)
            })
            .disposed(by: rx.disposeBag)
        
        backButton.rx.tap.asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.backButtonTapped?()
            })
            .disposed(by: rx.disposeBag)
    }
    
    private func configureAddShoppingButton(isExistInShoppingList: Bool) {
        addToShoppingButton.isHidden = isExistInShoppingList
    }
    
    private func configureLikeButton(isLiked: Bool) {
        favoriteImageView.image = UIImage(systemName: isLiked ? "heart.fill" :  "heart")
    }
    
    func configureCell(cocktail: CocktailDetail, isLiked: Bool, isShopping: Bool) {
        self.isLiked = isLiked
        self.isShopping = isShopping
        cocktailImageView.loadImageWithUrl(path: cocktail.drinkThumb)
        cocktailNameLabel.text = cocktail.title
        cocktailAlcoholicLabel.text = cocktail.alcoholic
        cocktailGlassLabel.text = cocktail.glass
        cocktailCategoryLabel.text = cocktail.category
        configureLikeButton(isLiked: isLiked)
        configureAddShoppingButton(isExistInShoppingList: isShopping)
    }
}
