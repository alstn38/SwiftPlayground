//
//  StockInfoView.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/14/25.
//

import SwiftUI

struct StockInfoView: View {
    let stockData: StockData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(stockData.name)
                .font(.callout)
                .foregroundStyle(.gray)
            
            HStack {
                Text(String(format: "%.2f", stockData.value))
                    .font(.footnote)
                    .foregroundStyle(.white)
                
                Text(String(format: "%.1f%%", stockData.changePercent))
                    .font(.footnote)
                    .foregroundStyle(stockData.changeState ? .red : .blue)
            }
        }
        .padding(.horizontal, 18)
    }
}
