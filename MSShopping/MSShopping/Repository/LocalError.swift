//
//  LocalError.swift
//  MSShopping
//
//  Created by 강민수 on 3/5/25.
//

import Foundation

enum LocalError: Error, LocalizedError {
    case createError
    
    var localizedDescription: String {
        switch self {
        case .createError: return "생성 오류"
        }
    }
}
