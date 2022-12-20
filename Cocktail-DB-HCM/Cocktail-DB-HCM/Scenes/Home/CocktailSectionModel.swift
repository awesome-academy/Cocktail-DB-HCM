//
//  CocktailSectionModel.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 17/12/2022.
//

import Foundation
import RxDataSources

enum CocktailsSection {
    case cocktails(items: [SectionItemCocktail])
}

enum SectionItemCocktail {
    case random(model: CocktailSession)
    case popular(model: CocktailSession)
    case latest(model: CocktailSession)
}

extension CocktailsSection: SectionModelType {
    typealias Item = SectionItemCocktail
    
    var items: [SectionItemCocktail] {
        switch self {
        case .cocktails(let items):
            return items.map { $0 }
        }
    }
    
    init(original: CocktailsSection, items: [Item]) {
        switch original {
        case .cocktails(let items):
            self = .cocktails(items: items)
        }
    }
}
