//
//  Lotto.swift
//  MSLotto
//
//  Created by 강민수 on 1/14/25.
//

import Foundation

struct Lotto: Decodable {
    let drawDate: String
    let firstWinnerMoney: Int
    let drawNumber1: Int
    let drawNumber2: Int
    let drawNumber3: Int
    let drawNumber4: Int
    let drawNumber5: Int
    let drawNumber6: Int
    let bonusNumber: Int
    let roundNumber: Int
    
    enum CodingKeys: String, CodingKey {
        case drawDate = "drwNoDate"
        case firstWinnerMoney = "firstWinamnt"
        case drawNumber1 = "drwtNo1"
        case drawNumber2 = "drwtNo2"
        case drawNumber3 = "drwtNo3"
        case drawNumber4 = "drwtNo4"
        case drawNumber5 = "drwtNo5"
        case drawNumber6 = "drwtNo6"
        case bonusNumber = "bnusNo"
        case roundNumber = "drwNo"
    }
}
