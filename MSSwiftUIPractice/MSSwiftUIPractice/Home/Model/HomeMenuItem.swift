//
//  HomeMenuItem.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/14/25.
//

import Foundation

struct HomeMenuItem: Identifiable {
    let id = UUID()
    let title: String
    let systemImage: String
}

extension HomeMenuItem {
    
    static let items: [HomeMenuItem] = [
        HomeMenuItem(title: "내 현금연수증", systemImage: "person.circle"),
        HomeMenuItem(title: "내 보혐료 점검하기", systemImage: "bell"),
        HomeMenuItem(title: "더 낸 연말정산 돌려받기", systemImage: "star")
    ]
}
