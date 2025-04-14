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
        HomeMenuItem(title: "내 정보", systemImage: "person.circle"),
        HomeMenuItem(title: "알림 설정", systemImage: "bell"),
        HomeMenuItem(title: "로그아웃", systemImage: "star")
    ]
}
