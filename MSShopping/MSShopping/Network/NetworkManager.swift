//
//  NetworkManager.swift
//  MSShopping
//
//  Created by 강민수 on 1/16/25.
//

import Alamofire
import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func getShoppingResult(searchedText: String, sortType: String, page: Int, completionHandler: @escaping (Result<Product, Error>) -> Void) {
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
                completionHandler(.failure(error))
            }
        }
    }
}
