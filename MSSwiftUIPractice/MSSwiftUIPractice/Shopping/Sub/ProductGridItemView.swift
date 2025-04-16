//
//  ProductGridItemView.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/16/25.
//

import SwiftUI

struct ProductGridItemView: View {
    let product: ProductItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: product.image)) { data in
                switch data {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure(_):
                    Image(systemName: "star")
                @unknown default:
                    EmptyView()
                }
            }
            .scaledToFit()
            .frame(width: 100, height: 100)
            .clipped()
            
            Text(product.title)
                .customTextStyle(font: .headline, color: .black)
                .lineLimit(1)
            
            Text(product.lowPrice)
                .customTextStyle(font: .subheadline, color: .black)
        }
        .padding()
        .background(Color.gray.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    ProductGridItemView(
        product: ProductItem(
            image: "https://picsum.photos/id/237/200/300",
            mallName: "도봉구",
            title: "사과",
            lowPrice: "3999원",
            favorite: true
        )
    )
}
