//
//  CocktailDetail.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 21/12/2022.
//

import Foundation
import RxCocoa
import RxSwift
import ObjectMapper

struct CocktailDetailResponse: Mappable {
    var drinks: [CocktailDetail]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        drinks <- map["drinks"]
    }
}

struct CocktailDetail {
    var id: String
    var title: String
    var category: String
    var glass: String
    var alcoholic: String
    var instruction: String
    var drinkThumb: String
    var ingredients: [Ingredient]
}

extension CocktailDetail {
    init() {
        self.init(
            id: "",
            title: "",
            category: "",
            glass: "",
            alcoholic: "",
            instruction: "",
            drinkThumb: "",
            ingredients: []
        )
    }
}

extension CocktailDetail: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["idDrink"]
        title <- map["strDrink"]
        category <- map["strCategory"]
        glass <- map["strGlass"]
        alcoholic <- map["strAlcoholic"]
        instruction <- map["strInstructions"]
        drinkThumb <- map["strDrinkThumb"]
        var flag = true
        var index = 1
        while flag {
            var tempName: String?
            var tempMeasure: String?
            tempName <- map["strIngredient\(index)"]
            tempMeasure <- map["strMeasure\(index)"]
            if let tempName = tempName, let tempMeasure = tempMeasure {
                let tempIngredient = Ingredient(name: tempName, measure: tempMeasure)
                ingredients.append(tempIngredient)
                index += 1
            } else {
                flag = false
            }
        }
    }
}
