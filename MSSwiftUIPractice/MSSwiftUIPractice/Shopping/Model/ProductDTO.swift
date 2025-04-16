//
//  ProductDTO.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/16/25.
//

import Foundation

struct ProductDTO: Decodable {
    let total: Int
    let items: [ProductInfoDTO]
}

struct ProductInfoDTO: Decodable {
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

extension ProductInfoDTO {
    
    func toEntity() -> ProductItem {
        return ProductItem(
            image: self.image,
            mallName: self.mallName,
            title: self.title.replacingOccurrences(
                of: "<[^>]+>|&quot;",
                with: "",
                options: .regularExpression,
                range: nil
            ),
            lowPrice: self.lowPrice,
            favorite: false
        )
    }
}
