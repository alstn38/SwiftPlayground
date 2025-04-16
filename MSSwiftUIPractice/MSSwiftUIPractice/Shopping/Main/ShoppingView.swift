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
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationWrapper {
            ScrollView {
                if isLoading {
                    ProgressView()
                } else {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach($products, id: \.id) { $item in
                            NavigationLink {
                                ProductDetailView(product: $item)
                            } label: {
                                ProductGridItemView(product: $item)
                            }
                        }
                    }
                }
            }
            .asLargeNavigationTitle("MS의 쇼핑쇼핑2")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onSubmit(of: .search) {
                Task {
                    await search()
                }
            }
            .alert("오류 발생", isPresented: $showAlert) {
                Button("확인", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func search() async {
        guard !searchText.isEmpty else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            let result = try await NetworkManager.shard.fetchShoppingResult(searchedText: searchText)
            products = result
        } catch {
            alertMessage = error.localizedDescription
            showAlert = true
            products = []
        }
    }
}

#Preview {
    ShoppingView()
}
