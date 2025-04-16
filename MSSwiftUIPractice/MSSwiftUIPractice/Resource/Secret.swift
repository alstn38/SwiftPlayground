//
//  Secret.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/16/25.
//

import Foundation

enum Secret {
    static let baseURL: String = {
        guard let urlString = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
            fatalError("BASE_URL ERROR")
        }
        return urlString
    }()
    
    static let clientID: String = {
        guard let accessToken = Bundle.main.infoDictionary?["CLIENT_ID"] as? String else {
            fatalError("CLIENT_ID ERROR")
        }
        return accessToken
    }()
    
    static let apiKey: String = {
        guard let urlString = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            fatalError("API_KEY ERROR")
        }
        return urlString
    }()
}
