//
//  NaverNetworkError.swift
//  MSShopping
//
//  Created by 강민수 on 2/25/25.
//

import Foundation

enum NaverNetworkError: Error, LocalizedError {
    case invalidRequest // 400
    case systemError // 500
    case decodingError
    case noPermission // 403
    case invalidAPI // 404
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
