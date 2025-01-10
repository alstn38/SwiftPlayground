//
//  ConvertDateFormatter.swift
//  MSTalk
//
//  Created by 강민수 on 1/10/25.
//

import Foundation

final class DateFormatterManager {
    
    static let shared = DateFormatterManager()
    private let dateFormatter: DateFormatter
    
    private init() {
        self.dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KO")
    }
    
    /// yyyy-MM-dd HH:mm 형식을 yy.MM.dd형식의 String으로 변환하는 메서드
    func convertDateString(_ dateString: String?) -> String? {
        guard let dateString else { return nil }
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        dateFormatter.dateFormat = "yy.MM.dd"
        let convertedDate = dateFormatter.string(from: date)
        
        return convertedDate
    }
}
