//
//  PhotoSectionItem.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/15/25.
//

import Foundation

struct PhotoSectionItem {
    let id = UUID()
    let sectionTitle: String
    let items: [PhotoItem]
}

struct PhotoItem {
    let id = UUID()
    let imageName: String
}

extension PhotoSectionItem {
    
    static let sections: [PhotoSectionItem] = [
        PhotoSectionItem(
            sectionTitle: "첫번째 섹션",
            items: [
                PhotoItem(imageName: "star"),
                PhotoItem(imageName: "heart"),
                PhotoItem(imageName: "bolt"),
                PhotoItem(imageName: "flame"),
                PhotoItem(imageName: "cloud"),
                PhotoItem(imageName: "sun.max"),
                PhotoItem(imageName: "moon"),
                PhotoItem(imageName: "leaf"),
                PhotoItem(imageName: "book"),
                PhotoItem(imageName: "message")
            ]
        ),
        PhotoSectionItem(
            sectionTitle: "두번째 섹션",
            items: [
                PhotoItem(imageName: "paperplane"),
                PhotoItem(imageName: "bubble.right"),
                PhotoItem(imageName: "bell"),
                PhotoItem(imageName: "tag"),
                PhotoItem(imageName: "bag"),
                PhotoItem(imageName: "cart"),
                PhotoItem(imageName: "creditcard"),
                PhotoItem(imageName: "gift"),
                PhotoItem(imageName: "camera"),
                PhotoItem(imageName: "mic")
            ]
        ),
        PhotoSectionItem(
            sectionTitle: "세번째 섹션",
            items: [
                PhotoItem(imageName: "person"),
                PhotoItem(imageName: "person.2"),
                PhotoItem(imageName: "person.crop.circle"),
                PhotoItem(imageName: "house"),
                PhotoItem(imageName: "car"),
                PhotoItem(imageName: "bicycle"),
                PhotoItem(imageName: "tram"),
                PhotoItem(imageName: "airplane"),
                PhotoItem(imageName: "globe"),
                PhotoItem(imageName: "map")
            ]
        ),
        PhotoSectionItem(
            sectionTitle: "네번째 섹션",
            items: [
                PhotoItem(imageName: "gamecontroller"),
                PhotoItem(imageName: "music.note"),
                PhotoItem(imageName: "film"),
                PhotoItem(imageName: "paintbrush"),
                PhotoItem(imageName: "scissors"),
                PhotoItem(imageName: "wrench"),
                PhotoItem(imageName: "hammer"),
                PhotoItem(imageName: "printer"),
                PhotoItem(imageName: "keyboard"),
                PhotoItem(imageName: "display")
            ]
        )
    ]

}
