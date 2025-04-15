//
//  ContentView.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/14/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("홈", systemImage: "house") {
                HomeView()
            }
            
            Tab("혜택", systemImage: "seal.fill") {
                BenefitView()
            }
            
            Tab("사진", systemImage: "photo") {
                PhotoView()
            }
            
            Tab("지갑", systemImage: "wallet.bifold") {
                WalletView()
            }
        }
        .tint(.black)
    }
}

#Preview {
    ContentView()
}
