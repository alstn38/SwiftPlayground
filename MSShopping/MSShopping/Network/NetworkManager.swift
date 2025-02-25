//
//  NetworkManager.swift
//  MSShopping
//
//  Created by 강민수 on 1/16/25.
//

import Foundation
import Alamofire
import RxSwift

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func getShoppingResult(searchedText: String, sortType: String, page: Int) -> Single<Result<Product, NaverNetworkError>> {
        
        return Single<Result<Product, NaverNetworkError>>.create { observer in
            let url = Bundle.main.mainURL + "?query=\(searchedText)&display=100&sort=\(sortType)&start=\(page)"
            let header: HTTPHeaders = [
                "X-Naver-Client-Id": Bundle.main.clientID,
                "X-Naver-Client-Secret": Bundle.main.apiKey
            ]
            
            AF.request(url, method: .get, headers: header)
                .validate(statusCode: 200...299)
                .responseDecodable(of: Product.self) { response in
                switch response.result {
                case .success(let value):
                    observer(.success(.success(value)))
                    
                case .failure(let error):
                    if error.underlyingError is DecodingError {
                        return observer(.success(.failure(.decodingError)))
                    }
                    
                    switch response.response?.statusCode {
                    case 400: return observer(.success(.failure(.invalidRequest)))
                    case 403: return observer(.success(.failure(.noPermission)))
                    case 404: return observer(.success(.failure(.invalidRequest)))
                    default: return observer(.success(.failure(.unknown(error.localizedDescription))))
                    }
                }
            }
            
            return Disposables.create()
        }
    }
    
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
