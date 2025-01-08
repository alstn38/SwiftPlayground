//
//  GameManager.swift
//  MSMiniGame
//
//  Created by 강민수 on 1/8/25.
//

import Foundation

protocol ThreeSixNineGameProtocol {
    var maxNumber: Int { get }
    
    func getTotalClapCount(selectedNumber: Int) -> Int
    func getGameResultArray(selectedNumber: Int) -> [String]
}

final class GameManager: ThreeSixNineGameProtocol {
    
    private(set) var maxNumber: Int
    private var totalClapCountDictionary: [Int: Int] = [:]
    
    init(maxNumber: Int) {
        self.maxNumber = maxNumber
        calculateTotalClapCount(maxNumber)
    }
    
    /// 선택된 숫자 까지의 전체 박수(👏)의 개수를 반환하는 메서드
    func getTotalClapCount(selectedNumber: Int) -> Int {
        guard selectedNumber <= maxNumber && selectedNumber >= 0 else { return 0 }
        
        return totalClapCountDictionary[selectedNumber] ?? 0
    }
    
    /// 3, 6, 9게임의 최대값 까지의 숫자를 박수(👏)가 포함된 배열로 반환하는 메서드
    func getGameResultArray(selectedNumber: Int) -> [String] {
        var resultArray: [String] = []
        
        for i in 1...selectedNumber {
            let newNumberString = changeClapEmoticon(i)
            resultArray.append(newNumberString)
        }
        
        return resultArray
    }
    
    private func calculateTotalClapCount(_ maxNumber: Int) {
        totalClapCountDictionary[0] = 0
        
        for i in 1...maxNumber {
            let beforeClapCount: Int = totalClapCountDictionary[i - 1] ?? 0
            totalClapCountDictionary[i] = beforeClapCount + getClapCount(i)
        }
    }
    
    private func getClapCount(_ number: Int) -> Int {
        let numberString: [Character] = String(number).map { $0 }
        let targets: [Character] = ["3", "6", "9"]
        
        return numberString.filter { targets.contains($0) }.count
    }
    
    private func changeClapEmoticon(_ number: Int) -> String {
        var numberString = String(number)
        let targets: [String] = ["3", "6", "9"]
        
        for target in targets {
            numberString = numberString.replacingOccurrences(of: target, with: "👏")
        }
        
        return numberString
    }
}
