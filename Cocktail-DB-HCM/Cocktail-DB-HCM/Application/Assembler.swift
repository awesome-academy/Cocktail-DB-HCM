//
//  Assembler.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 13/12/2022.
//

import Foundation

protocol Assembler: AnyObject,
                    AppAssembler,
                    TabbarAssembler,
                    HomeAssembler,
                    SearchAssembler,
                    ShoppingAssembler,
                    FavoriteAssembler,
                    DetailAssembler,
                    CategoryAssembler {
}

final class DefaultAssembler: Assembler {
}
