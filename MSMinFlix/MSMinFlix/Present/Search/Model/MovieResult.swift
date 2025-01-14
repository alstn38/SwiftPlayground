//
//  MovieResult.swift
//  MSMinFlix
//
//  Created by 강민수 on 1/14/25.
//

import Foundation

struct MovieResult: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Decodable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Decodable {
    let rank: String
    let movieName: String
    let openDate: String

    enum CodingKeys: String, CodingKey {
        case rank
        case movieName = "movieNm"
        case openDate = "openDt"
    }
}
