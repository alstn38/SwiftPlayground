//
//  NetworkManager.swift
//  MSShopping
//
//  Created by 강민수 on 1/16/25.
//

import Alamofire
import Foundation

enum NaverNetworkError: Error {
    case invalidRequest // 400
    case systemError // 500
    case decodingError
    case noPermission // 403
    case invalidAPI // 404
    case unknown(String)
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func getShoppingResult(searchedText: String, sortType: String, page: Int, completionHandler: @escaping (Result<Product, NaverNetworkError>) -> Void) {
        guard let encodeString = searchedText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = Bundle.main.mainURL + "?query=\(encodeString)&display=30&sort=\(sortType)&start=\(page)"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": Bundle.main.clientID,
            "X-Naver-Client-Secret": Bundle.main.apiKey
        ]
        
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: Product.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                guard let statusCode = response.response?.statusCode else {
                    return completionHandler(.failure(.unknown(error.localizedDescription)))
                }
                
                switch statusCode {
                case 400: return completionHandler(.failure(.invalidRequest))
                case 403: return completionHandler(.failure(.noPermission))
                case 404: return completionHandler(.failure(.invalidAPI))
                default: return completionHandler(.failure(.decodingError))
                }
            }
        }
    }
}
