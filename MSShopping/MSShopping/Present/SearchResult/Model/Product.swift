//
//  Product.swift
//  MSShopping
//
//  Created by 강민수 on 1/15/25.
//

import Foundation

struct Product: Decodable {
    let total: Int
    let items: [Item]
}

struct Item: Decodable {
    let image: String
    let mallName: String
    let title: String
    let lowPrice: String

    enum CodingKeys: String, CodingKey {
        case image, mallName, title
        case lowPrice = "lprice"
    }
}
