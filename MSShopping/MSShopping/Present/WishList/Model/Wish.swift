//
//  Wish.swift
//  MSShopping
//
//  Created by 강민수 on 2/26/25.
//

import Foundation

struct Wish: Hashable, Identifiable {
    let id = UUID()
    let productName: String
    let date = Date()
}
