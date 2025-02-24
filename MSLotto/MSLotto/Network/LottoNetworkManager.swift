//
//  LottoNetworkManager.swift
//  MSLotto
//
//  Created by 강민수 on 2/24/25.
//

import Foundation
import Alamofire
import RxSwift

final class LottoNetworkManager {
    
    static let shared = LottoNetworkManager()
    
    private init() { }
    
    func getLottoResultObserver(roundNumber: Int) -> Observable<Lotto> {
        return Observable<Lotto>.create { observer in
            let urlString = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(roundNumber)"
            
            guard let url = URL(string: urlString) else {
                observer.onError(LottoNetworkError.invalidURL)
                return Disposables.create()
            }
            
            AF.request(url, method: .get)
                .validate(statusCode: 200...299)
                .responseDecodable(of: Lotto.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                        
                    case .failure(let error):
                        if error.underlyingError is DecodingError {
                            observer.onError(LottoNetworkError.decodeError)
                        } else {
                            observer.onError(LottoNetworkError.unownedError)
                        }
                    }
                }
            return Disposables.create()
        }
    }
    
    func getLottoResultSingle(roundNumber: Int) -> Single<Lotto> {
        return Single<Lotto>.create { observer in
            let urlString = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(roundNumber)"
            
            guard let url = URL(string: urlString) else {
                observer(.failure(LottoNetworkError.invalidURL))
                return Disposables.create()
            }
            
            AF.request(url, method: .get)
                .validate(statusCode: 200...299)
                .responseDecodable(of: Lotto.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer(.success(value))
                        
                    case .failure(let error):
                        if error.underlyingError is DecodingError {
                            observer(.failure(LottoNetworkError.decodeError))
                        } else {
                            observer(.failure(LottoNetworkError.invalidURL))
                        }
                    }
                }
            return Disposables.create()
        }
    }
}
