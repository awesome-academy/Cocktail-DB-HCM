//
//  DetailSectionModel.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 21/12/2022.
//

import Foundation
import RxDataSources
import UIKit
import RxCocoa
import RxSwift

enum DetailsSectionModel {
    case detail(items: [SectionItems])
}

enum SectionItems {
    case info(model: CocktailDetail, likedStatus: Bool, shoppingStatus: Bool)
    case description(model: String)
    case ingredient(model: [Ingredient])
    case similar(model: [Cocktail])
}

extension DetailsSectionModel: SectionModelType {
    
    typealias Item = SectionItems
    
    var items: [SectionItems] {
        switch self {
        case .detail(let items):
            return items.map { $0 }
        }
    }
    
    init(original: DetailsSectionModel, items: [Item]) {
        switch original {
        case .detail:
            self = .detail(items: items)
        }
    }
}
