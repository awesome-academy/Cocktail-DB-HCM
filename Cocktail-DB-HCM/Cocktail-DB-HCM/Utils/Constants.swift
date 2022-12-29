//
//  Constants.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 18/12/2022.
//

import Foundation
import UIKit

enum CocktailCategory: String, CaseIterable {
    case popular = "popular"
    case latest = "latest"
    case random = "randomselection"
    case none = ""
    
    var getTitle: String {
        switch self {
        case .popular:
            return "Popular"
        case .latest:
            return "Latest"
        case .none:
            return ""
        case .random:
            return "What to drink today?"
        }
    }
}

enum AppConstants {
    static let basePadding = 16.0
    static let zeroPadding = 0.0
    static let baseCornerRadius = 10.0
}

enum HomeScreenConstants {
    static let heightTableViewCell = 316.0
    static let heightTableViewPosterCell = 350.0
    static let heightCollectionViewCell = 250.0
    static let heightCollectionViewPosterCell = 300.0
}

enum SearchScreenConstants {
    static let heightTableViewCell = 200.0
    static let cornerRadiusCellValue = 20.0
    static let debounceTime = 1000
}

enum SimilarCellConstants {
    static let heightCollectionViewCell = 250.0
    static let widthCollectionViewCell = 300.0
}

enum IngredientCellConstants {
    static let heightCollectionViewCell = 220.0
    static let widthCollectionViewCell = 120.0
}

enum DetailTableViewCell {
    static let similarRowHeight = 600.0
    static let ingredientRowHeight = 245.0
}

enum DatabaseError: Error {
    case addCocktailFailed
    case deleteCocktailFailed
    case checkCocktailExistFailed
    case getAllCocktailFailed
}

enum FavoriteCollectionCell {
    static let spacing = 16
    static let heightCollectionViewCell = 250.0
}

enum PageViewSetup {
    static let heightLoadingView = 100.0
    static let numberOfItemPerPage = 10
    static let offsetConditionForReload = -100.0
}

func createSpinner(width: CGFloat) -> UIView {
    let spinnerBackgroundView = UIView(
        frame: CGRect(
            x: 0,
            y: 0,
            width: width,
            height: PageViewSetup.heightLoadingView))
    
    let spinner = UIActivityIndicatorView().then {
        $0.center = spinnerBackgroundView.center
        $0.startAnimating()
        $0.color = .white
    }
    
    spinnerBackgroundView.addSubview(spinner)
    return spinnerBackgroundView
}
