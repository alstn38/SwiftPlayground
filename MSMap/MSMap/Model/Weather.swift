//
//  Weather.swift
//  MSMap
//
//  Created by 강민수 on 2/3/25.
//

import Foundation

struct Weather: Codable {
    let main: WeatherDetail
    let wind: Wind
}

struct WeatherDetail: Codable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Wind: Codable {
    let speed: Double
}
