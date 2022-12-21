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
