//
//  LottoNetworkError.swift
//  MSLotto
//
//  Created by 강민수 on 2/24/25.
//

import Foundation

enum LottoNetworkError: Error, LocalizedError {
    case invalidURL
    case decodeError
    case unownedError
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "잘못된 URL입니다."
        case .decodeError:
            return "decode Error"
        case .unownedError:
            return "unowned Error"
        }
    }
}
