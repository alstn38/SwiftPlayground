//
//  ProductDetailView.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/16/25.
//

import SwiftUI

struct ProductDetailView: View {
    @Binding var product: ProductItem
    
    var body: some View {
        VStack(spacing: 10) {
            AsyncImage(url: URL(string: product.image)) { image in
                switch image {
                case .empty:
                    Image(systemName: "star")
                case .success(let image):
                    image
                case .failure(_):
                    Image(systemName: "star")
                @unknown default:
                    Image(systemName: "star")
                }
            }
            .scaledToFit()
            .frame(width: 100, height: 100)
            
            Text(product.title)
                .customTextStyle(font: .title2, color: .black)
                .fontWeight(.heavy)
            
            Text(product.mallName)
                .customTextStyle(font: .headline, color: .black)
                .fontWeight(.medium)
            
            Text(product.lowPrice)
                .customTextStyle(font: .footnote, color: .black)
            
            Image(systemName: product.favorite ? "star.fill" : "star")
                .tint(.black)
                .wrapToButton {
                    print("토글")
                }
        }
    }
}
