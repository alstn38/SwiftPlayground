//
//  String+.swift
//  MSTravel
//
//  Created by 강민수 on 1/3/25.
//

import Foundation

extension String {
    
    /// yymmdd값 날짜를 yy년 mm월 dd일로 변환하는 메서드
    func formatToDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yymmdd"
        
        guard let date = formatter.date(from: self) else { return "날짜 정보 없음"}
        formatter.dateFormat = "yy년 mm월 dd일"
        
        return formatter.string(from: date)
    }
}
