//
//  Product.swift
//  MSShopping
//
//  Created by 강민수 on 1/15/25.
//

import Foundation

struct Product: Decodable {
    let total: Int
    let items: [ProductInfo]
}

struct ProductInfo: Decodable {
    let image: String
    let mallName: String
    let title: String
    let link: String
    let lowPrice: String
    let productId: String

    enum CodingKeys: String, CodingKey {
        case image, mallName, title, link, productId
        case lowPrice = "lprice"
    }
}

extension ProductInfo {
    
    func toEntity(isFavorite: Bool) -> ProductEntity {
        return ProductEntity(
            image: self.image,
            mallName: self.mallName,
            title: self.title,
            link: self.link,
            lowPrice: self.lowPrice,
            productId: self.productId,
            favorite: isFavorite
        )
    }
}
