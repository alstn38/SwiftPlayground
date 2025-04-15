//
//  DetailWalletView.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/15/25.
//

import SwiftUI

struct DetailWalletView: View {
    @Binding var item: WalletItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .customTextStyle(font: .title3, color: .black)
                    .bold()
                Text(item.subtitle)
                    .customTextStyle(font: .callout, color: .gray)
            }
            Spacer()
            Text("\(item.money.formatted())원")
            
            if item.isFavorite {
                Button {
                    item.isFavorite.toggle()
                } label: {
                    Image(systemName: "star.fill")
                }
            } else {
                Button {
                    item.isFavorite.toggle()
                } label: {
                    Image(systemName: "star")
                }
            }
        }
        .padding()
    }
}
