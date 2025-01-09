//
//  GameManager.swift
//  MSUpDownGame
//
//  Created by 강민수 on 1/9/25.
//

import Foundation

protocol GameManagerProtocol {
    var remainingNumberArray: [Int] { get }
    
    func isCollectNumber(_ number: Int) -> Bool
}

final class GameManager: GameManagerProtocol {
    
    /// 남은 선택 순자 배열
    var remainingNumberArray: [Int] {
        return Array(allNumberArray[down...up])
    }
    
    private let allNumberArray: [Int]
    private let answerNumber: Int
    private var down: Int = 1
    private var up: Int
    
    init(maxNumber: Int) {
        self.allNumberArray = Array(0...maxNumber)
        self.answerNumber = allNumberArray.randomElement() ?? 1
        self.up = maxNumber
    }
    
    /// 해당 숫자가 정답이 맞는지 결과를 확인하는 메서드
    func isCollectNumber(_ selectNumber: Int) -> Bool {
        if selectNumber == answerNumber {
            return true
        } else {
            changeUpDownNumber(selectNumber)
            return false
        }
    }
    
    /// 선택된 번호에 맞게 정답 범위를 수정하는 메서드
    private func changeUpDownNumber(_ selectNumber: Int) {
        if selectNumber > answerNumber {
            up = selectNumber - 1
        } else if selectNumber < answerNumber {
            down = selectNumber + 1
        }
    }
}
