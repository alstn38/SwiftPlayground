//
//  WishCategoryRepository.swift
//  MSShopping
//
//  Created by 강민수 on 3/5/25.
//

import Foundation
import RealmSwift

protocol WishCategoryRepository {
    func getFileURL() -> URL?
    func readItem() -> [WishCategory]
    func createItem(name: String) throws
}

final class DefaultWishCategoryRepository: WishCategoryRepository {
    
    private let realm = try! Realm()
    
    func getFileURL() -> URL? {
        return realm.configuration.fileURL
    }
    
    func readItem() -> [WishCategory] {
        let data = Array(realm.objects(WishCategory.self))
        return data
    }
    
    func createItem(name: String) throws {
        do {
            try realm.write {
                let data = WishCategory(folderName: name)
                realm.add(data)
            }
        } catch {
            throw LocalError.createError
        }
    }
}
