//
//  PhotoSectionView.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/15/25.
//

import SwiftUI

struct PhotoSectionView: View {
    
    let section: PhotoSectionItem
    
    var body: some View {
        VStack {
            Text(section.sectionTitle)
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            ScrollView(.horizontal) {
                LazyHStack(spacing: 10) {
                    ForEach(section.items, id: \.id) { item in
                        makeImageView(item)
                    }
                }
                
                .padding(.horizontal)
            }
            .scrollIndicators(.hidden)
        }
    }
    
    func makeImageView(_ item: PhotoItem) -> some View {
        Image(systemName: item.imageName)
            .frame(width: 120, height: 150)
            .background(Color.gray)
            .clipShape(.buttonBorder)
    }
}

#Preview {
    PhotoSectionView(section: PhotoSectionItem(sectionTitle: "첫번째 섹션", items: [
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
    ]))
}
