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

struct CocktailResponse: Mappable {
    var drinks: [Cocktail]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        drinks <- map["drinks"]
    }
}

struct Cocktail {
    var id: Int
    var strDrink: String
    var strCategory: String
    var strAlcoholic: String
    var strGlass: String
    var strInstructions: String
    var strDrinkThumb: String
}

extension Cocktail {
    init() {
        self.init(id: 0,
                  strDrink: "",
                  strCategory: "",
                  strAlcoholic: "",
                  strGlass: "",
                  strInstructions: "",
                  strDrinkThumb: "")
    }
}

extension Cocktail: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        strDrink <- map["strDrink"]
        strCategory <- map["strCategory"]
        strAlcoholic <- map["strAlcoholic"]
        strGlass <- map["strGlass"]
        strInstructions <- map["strInstructions"]
        strDrinkThumb <- map["strDrinkThumb"]
    }
}
