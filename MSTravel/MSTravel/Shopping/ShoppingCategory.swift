//
//  ShoppingCategory.swift
//  MSTravel
//
//  Created by 강민수 on 1/4/25.
//

import Foundation

struct ShoppingCategory {
    let title: String
    var isChecked: Bool = false
    var isLiked: Bool = false
    
    mutating func toggleChecked() {
        self.isChecked.toggle()
    }
    
    mutating func toggleLiked() {
        self.isLiked.toggle()
    }
}

struct ShoppingCategoryInfo {
    let shoppingCategory: [ShoppingCategory] = [
        ShoppingCategory(title: "그립톡 구매하기", isChecked: true, isLiked: true),
        ShoppingCategory(title: "사이다 구매", isChecked: false, isLiked: false),
        ShoppingCategory(title: "아이패드 케이스 최저가 알아보기", isChecked: false, isLiked: true),
        ShoppingCategory(title: "양말", isChecked: false, isLiked: true)
    ]
}
