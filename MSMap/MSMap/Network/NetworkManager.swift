//
//  NetworkManager.swift
//  MSMap
//
//  Created by 강민수 on 2/3/25.
//

import Alamofire
import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func request<T: Decodable>(
        urlRequest: URLRequestConvertible,
        responseType: T.Type,
        completionHandler: @escaping (Result<T, AFError>) -> Void
    ) {
        let url = try? urlRequest.asURLRequest().url
        print(url)
        
        AF.request(urlRequest)
            .validate(statusCode: 200...299)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(.success(value))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
}
