//
//  NetworkManager.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/16/25.
//

import Foundation

final class NetworkManager {
    
    static let shard = NetworkManager()
    
    private init() {}
    
    func fetchShoppingResult(searchedText: String) async throws -> [ProductItem] {
        guard let encodeString = searchedText.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        ) else {
            throw ShoppingError.invalidRequest
        }
        
        guard let url = URL(string: Secret.baseURL + "?query=\(encodeString)&display=20&start=1" ) else {
            throw ShoppingError.invalidRequest
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(Secret.clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.setValue(Secret.apiKey, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw ShoppingError.invalidAPI
        }
        
        do {
            let decoded = try JSONDecoder().decode(ProductDTO.self, from: data)
            return decoded.items.map { $0.toEntity() }
        } catch {
            throw ShoppingError.decodingError
        }
    }
}
