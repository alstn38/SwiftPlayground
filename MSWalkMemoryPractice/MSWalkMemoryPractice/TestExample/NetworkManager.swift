//
//  NetworkManager.swift
//  MSWalkMemoryPractice
//
//  Created by 강민수 on 4/7/25.
//

import Alamofire
import Foundation

protocol NetworkProvider {
    func fetchLotto(completionHandler: @escaping (Lotto) -> Void)
}

struct Lotto: Codable {
   let drwNoDate: String
   let bnusNo: Int
   let drwtNo1: Int
}

class NetworkManager {
   
   static let shared = NetworkManager()
   
   private init() { }
    
   let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1000"
   
   func fetchLotto(completionHandler: @escaping (Lotto) -> Void) {
       AF.request(url).responseDecodable(of: Lotto.self) { response in
           switch response.result {
           case .success(let success):
               completionHandler(success)
           case .failure(let failure):
               print(failure)
           }
       }
   }
}
