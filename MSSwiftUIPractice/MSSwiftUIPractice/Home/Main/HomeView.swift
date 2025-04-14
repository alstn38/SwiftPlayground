//
//  HomeView.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/14/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            HStack {
                Button { print("클릭됨") } label: {
                    CountryView(systemImageName: "star", label: "국내주식")
                }
                Button { print("클릭됨") } label: {
                    CountryView(systemImageName: "star", label: "해외주식")
                }
                Button { print("클릭됨") } label: {
                    CountryView(systemImageName: "star", label: "채권")
                }
                Button { print("클릭됨") } label: {
                    CountryView(systemImageName: "star", label: "ETF")
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(StockData.sampleStocks.indices, id: \.self) { index in
                        HStack(spacing: 0) {
                            StockInfoView(stockData: StockData.sampleStocks[index])

                            if index != StockData.sampleStocks.count - 1 {
                                VerticalDividerView()
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.top, 30)
            
            HStack {
                Button { print("클릭됨") } label: {
                    EventView(title: "숨은 환급액\n찾기")
                }
                Button { print("클릭됨") } label: {
                    EventView(title: "혜택 받는\n신용카드")
                }
            }
            .padding(.top, 14)
            .padding(.horizontal, 16)
            
            List {
                ForEach(HomeMenuItem.items) { item in
                    HomeItemView(homeMenuItem: item)
                        .listRowBackground(Color.gray.opacity(0.2))
                        .padding(.vertical, 8)
                }
            }
            .scrollContentBackground(.hidden)
            .listStyle(.insetGrouped)
            .padding(.top, 12)
            
            Spacer()
        }
        .background(.black)
    }
}

#Preview {
    HomeView()
}
