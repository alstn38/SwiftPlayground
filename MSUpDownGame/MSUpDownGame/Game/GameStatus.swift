//
//  GameStatus.swift
//  MSUpDownGame
//
//  Created by 강민수 on 1/9/25.
//

import Foundation

struct GameStatus {
    var tryCount: Int
    var upDownStatus: UpDownStatus
    var tryCountDescription: String {
        return "시도 횟수: \(tryCount)"
    }
    
    mutating func changeStatus(_ status: UpDownStatus) {
        self.tryCount += 1
        self.upDownStatus = status
    }
}

enum UpDownStatus {
    case up
    case down
    case correct
    
    var title: String {
        switch self {
        case .up:
            "UP"
        case .down:
            "DOWN"
        case .correct:
            "GOOD"
        }
    }
}
