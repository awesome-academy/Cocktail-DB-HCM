//
//  Cocktail.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 17/12/2022.
//

import Foundation
import ObjectMapper
import Then

struct CocktailSession {
    var category: CocktailCategory = .none
    var cocktails = [Cocktail]()
}

struct SimilarCocktailSession {
    var category = ""
    var cocktails = [Cocktail]()
}

struct CocktailResponse: Mappable {
    var drinks: [Cocktail]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        drinks <- map["drinks"]
    }
}

struct Cocktail {
    var id: String
    var strDrink: String
    var strCategory: String
    var strAlcoholic: String
    var strGlass: String
    var strInstructions: String
    var strDrinkThumb: String
    var ingredients: [Ingredient]
}

extension Cocktail {
    init() {
        self.init(id: "",
                  strDrink: "",
                  strCategory: "",
                  strAlcoholic: "",
                  strGlass: "",
                  strInstructions: "",
                  strDrinkThumb: "",
                  ingredients: [])
    }
}

extension Cocktail: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["idDrink"]
        strDrink <- map["strDrink"]
        strCategory <- map["strCategory"]
        strAlcoholic <- map["strAlcoholic"]
        strGlass <- map["strGlass"]
        strInstructions <- map["strInstructions"]
        strDrinkThumb <- map["strDrinkThumb"]
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

struct Ingredient {
    var name = ""
    var measure = ""
}
