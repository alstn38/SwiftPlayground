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
    
    var description: String {
        return """
        현재 온도: \(String(format: "%.1f", main.temp - 273.15))°C
        최고 온도: \(String(format: "%.1f", main.tempMax - 273.15))°C
        최저 온도: \(String(format: "%.1f", main.tempMin - 273.15))°C
        습도: \(main.humidity)%
        풍속: \(wind.speed)m/s
        """
    }
}

struct WeatherDetail: Codable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
    }
}

struct Wind: Codable {
    let speed: Double
}
