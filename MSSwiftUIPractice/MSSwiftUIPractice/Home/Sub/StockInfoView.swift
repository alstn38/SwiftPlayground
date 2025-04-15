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
                .customTextStyle(font: .callout, color: .gray)
            
            HStack {
                Text(String(format: "%.2f", stockData.value))
                    .customTextStyle(font: .footnote, color: .white)
                
                Text(String(format: "%.1f%%", stockData.changePercent))
                    .customTextStyle(font: .footnote, color: stockData.changeState ? .red : .blue)
            }
        }
        .padding(.horizontal, 18)
    }
}
