//
//  WishCategory.swift
//  MSShopping
//
//  Created by 강민수 on 3/5/25.
//

import Foundation
import RealmSwift

final class WishCategory: Object {
    @Persisted(primaryKey: true) var productId: ObjectId
    @Persisted var folderName: String
    @Persisted var detail: List<WishList>
    
    convenience init(folderName: String) {
        self.init()
        self.folderName = folderName
    }
}
