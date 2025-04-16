//
//  ProductGridItemView.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/16/25.
//

import SwiftUI

struct ProductGridItemView: View {
    @Binding var product: ProductItem
    
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
            
            HStack {
                Text(product.lowPrice)
                    .customTextStyle(font: .subheadline, color: .black)
                Image(systemName: product.favorite ? "star.fill" : "star")
                    .tint(.black)
                    .wrapToButton {
                        product.favorite.toggle()
                    }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
