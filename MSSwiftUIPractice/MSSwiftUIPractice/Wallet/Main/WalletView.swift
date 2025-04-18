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
            .asLargeNavigationTitle("MS Wallet")
        }
    }
    
    
    func walletItemView(for item: WalletItem) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .customTextStyle(font: .title3, color: .black)
                    .bold()
                Text(item.subtitle)
                    .font(.callout)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Text("\(item.money.formatted())원")
                .customTextStyle(font: .callout, color: .black)
        }
    }
}

#Preview {
    WalletView()
}
