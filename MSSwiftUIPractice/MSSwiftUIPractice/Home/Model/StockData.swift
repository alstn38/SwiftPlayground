//
//  StockData.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/14/25.
//

import Foundation

struct StockData: Identifiable {
    let id = UUID()
    let name: String
    let value: Double
    let changePercent: Double
    let changeState: Bool
}

extension StockData {
    static let sampleStocks: [StockData] = [
        StockData(name: "코스피", value: 2689.23, changePercent: 1.2, changeState: true),
        StockData(name: "코스닥", value: 859.44, changePercent: -0.7, changeState: false),
        StockData(name: "나스닥", value: 15222.81, changePercent: 2.4, changeState: true),
        StockData(name: "S&P500", value: 5172.24, changePercent: -0.3, changeState: false)
    ]
}
