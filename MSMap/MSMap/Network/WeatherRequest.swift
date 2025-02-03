//
//  Weather.swift
//  MSMap
//
//  Created by 강민수 on 2/3/25.
//

import Alamofire
import Foundation

enum WeatherRequest: URLRequestConvertible {
    case currentWeather(latitude: Double, longitude: Double)
    
    var baseURL: String {
        return Bundle.main.mainURL
    }
    
    var method: HTTPMethod {
        switch self {
        case .currentWeather:
            return .get
        }
    }
    
    var path: String {
        return "/data/2.5/weather"
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .currentWeather(let latitude, let longitude):
            return [
                URLQueryItem(name: "lat", value: String(latitude)),
                URLQueryItem(name: "lon", value: String(longitude)),
                URLQueryItem(name: "appid", value: Bundle.main.apiKey)
            ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var components = URLComponents(string: baseURL)
        components?.path = path
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            throw NetworkError.urlError
        }
        
        var request = URLRequest(url: url)
        request.method = method
        return request
    }
}
