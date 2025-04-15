//
//  WalletView.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/15/25.
//

import SwiftUI

struct WalletView: View {
    @State private var walletItems: [WalletItem] = WalletItem.items
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(walletItems.indices, id: \.self) { index in
                        NavigationLink {
                            DetailWalletView(item: $walletItems[index])
                        } label: {
                            walletItemView(for: walletItems[index])
                        }
                    }
                }
                .padding()
            }
        }
    }
    
    
    func walletItemView(for item: WalletItem) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.black)
                Text(item.subtitle)
                    .font(.callout)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Text("\(item.money.formatted())원")
                .font(.callout)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    WalletView()
}
