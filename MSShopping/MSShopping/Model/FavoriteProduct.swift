//
//  FavoriteProduct.swift
//  MSShopping
//
//  Created by 강민수 on 3/4/25.
//

import Foundation
import RealmSwift

final class FavoriteProduct: Object, Identifiable {
    @Persisted(primaryKey: true) var productId: String
    @Persisted var image: String
    @Persisted var mallName: String
    @Persisted(indexed: true) var title: String
    @Persisted var link: String
    @Persisted var lowPrice: String
    @Persisted var favorite: Bool
    
    convenience init(_ item: ProductEntity) {
        self.init()
        self.productId = item.productId
        self.image = item.image
        self.mallName = item.mallName
        self.title = item.title
        self.link = item.link
        self.lowPrice = item.lowPrice
        self.favorite = item.favorite
    }
    
    func toEntity() -> ProductEntity {
        return ProductEntity(
            image: self.image,
            mallName: self.mallName,
            title: self.title,
            link: self.link,
            lowPrice: self.lowPrice,
            productId: self.productId,
            favorite: self.favorite
        )
    }
}
