//
//  CocktailEntity+CoreDataProperties.swift
//  
//
//  Created by le.n.t.trung on 22/12/2022.
//
//

import Foundation
import CoreData

extension CocktailEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CocktailEntity> {
        return NSFetchRequest<CocktailEntity>(entityName: "CocktailEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var strAlcoholic: String?
    @NSManaged public var strCategory: String?
    @NSManaged public var strDrink: String?
    @NSManaged public var strDrinkThumb: String?
    @NSManaged public var strGlass: String?
    @NSManaged public var strInstructions: String?

}
