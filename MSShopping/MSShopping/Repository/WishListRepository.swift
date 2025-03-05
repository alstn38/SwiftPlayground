//
//  WishListRepository.swift
//  MSShopping
//
//  Created by 강민수 on 3/5/25.
//

import Foundation
import RealmSwift

protocol WishListRepository {
    func createItem(folder: WishCategory, name: String) throws
}

final class DefaultWishListRepository: WishListRepository {
    
    private let realm = try! Realm()
    
    func createItem(folder: WishCategory, name: String) throws {
        do {
            try realm.write {
                let data = WishList(productName: name)
                folder.detail.append(data)
            }
        } catch {
            throw LocalError.createError
        }
    }
}
