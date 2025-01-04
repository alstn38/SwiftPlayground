//
//  Int+.swift
//  MSTravel
//
//  Created by 강민수 on 1/4/25.
//

import Foundation

extension Int {
    
    /// 3자리마다 콤마(,)를 넣어주는 메서드
    func formatToDecimalNumber() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter.string(for: self) ?? "0"
    }
}
