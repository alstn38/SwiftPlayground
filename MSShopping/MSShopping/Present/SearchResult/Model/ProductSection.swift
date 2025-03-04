//
//  ProductSection.swift
//  MSShopping
//
//  Created by 강민수 on 2/25/25.
//

import Foundation
import RxDataSources

struct ProductSection {
    var items: [ProductEntity]
}

extension ProductSection: SectionModelType {
    typealias Item = ProductEntity
    
    init(original: ProductSection, items: [ProductEntity]) {
        self = original
        self.items = items
    }
}
