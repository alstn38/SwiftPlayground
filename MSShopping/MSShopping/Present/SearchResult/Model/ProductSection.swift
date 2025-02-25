//
//  ProductSection.swift
//  MSShopping
//
//  Created by 강민수 on 2/25/25.
//

import Foundation
import RxDataSources

struct ProductSection {
    var items: [ProductInfo]
}

extension ProductSection: SectionModelType {
    typealias Item = ProductInfo
    
    init(original: ProductSection, items: [ProductInfo]) {
        self = original
        self.items = items
    }
}
