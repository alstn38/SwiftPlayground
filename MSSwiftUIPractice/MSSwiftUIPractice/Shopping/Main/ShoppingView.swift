//
//  ShoppingView.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/16/25.
//

import SwiftUI

struct ShoppingView: View {
    @State private var searchText = ""
    @State private var products: [ProductItem] = []
    @State private var isLoading: Bool = false
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationWrapper {
            ScrollView {
                if isLoading {
                    ProgressView()
                } else {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach($products, id: \.self) { $item in
                            NavigationLink {
                                ProductDetailView(product: $item)
                            } label: {
                                ProductGridItemView(product: item)
                            }
                        }
                    }
                }
            }
            .asLargeNavigationTitle("MS의 쇼핑쇼핑2")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onSubmit(of: .search) {
                print(searchText)
            }
        }
        .onAppear {
            products = ProductItem.items
        }
    }
}

#Preview {
    ShoppingView()
}
