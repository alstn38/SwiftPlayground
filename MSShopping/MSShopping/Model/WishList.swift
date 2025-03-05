//
//  WishList.swift
//  MSShopping
//
//  Created by 강민수 on 3/5/25.
//

import Foundation
import RealmSwift

final class WishList: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var productName: String
    @Persisted var date: Date
    
    @Persisted(originProperty: "detail")
    var folder: LinkingObjects<WishCategory>
    
    convenience init(productName: String) {
        self.init()
        self.productName = productName
        self.date = Date()
    }
}
