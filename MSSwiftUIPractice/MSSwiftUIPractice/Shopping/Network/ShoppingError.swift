//
//  ShoppingError.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/16/25.
//

import Foundation

enum ShoppingError: Error, LocalizedError {
    case invalidRequest
    case systemError
    case decodingError
    case noPermission
    case invalidAPI
    case unknown(String)
    
    var errorDescription: String {
        switch self {
        case .invalidRequest: return "invalidRequest"
        case .systemError: return "systemError"
        case .decodingError: return "decodingError"
        case .noPermission: return "noPermission"
        case .invalidAPI: return "invalidAPI"
        case .unknown(let error): return error
        }
    }
}
