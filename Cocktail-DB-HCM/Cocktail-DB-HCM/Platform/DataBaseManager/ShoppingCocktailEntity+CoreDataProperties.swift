//
//  ShoppingCocktailEntity+CoreDataProperties.swift
//  
//
//  Created by le.n.t.trung on 23/12/2022.
//
//

import Foundation
import CoreData

extension ShoppingCocktailEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingCocktailEntity> {
        return NSFetchRequest<ShoppingCocktailEntity>(entityName: "ShoppingCocktailEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var instructions: String?
    @NSManaged public var thumb: String?
    @NSManaged public var ingredients: [NSString]?
    @NSManaged public var measures: [NSString]?

}
