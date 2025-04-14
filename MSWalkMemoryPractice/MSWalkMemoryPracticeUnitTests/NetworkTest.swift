//
//  NetworkTest.swift
//  MSWalkMemoryPracticeUnitTests
//
//  Created by 강민수 on 4/7/25.
//

import XCTest
@testable import MSWalkMemoryPractice

final class NetworkTest: XCTestCase {

    var sut: NetworkManager!
    
    override func setUpWithError() throws {
        sut = NetworkManager.shared
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    /// response lotto bonus NO 1 - 45
    func testExample() throws {
        // 1) expectation
        let promise = expectation(description: "Lotto API CompletionHandler")
        
        sut.fetchLotto { lotto in
            let value = lotto.bnusNo
            
            XCTAssertLessThanOrEqual(value, 45)
            XCTAssertGreaterThanOrEqual(value, 1)
            
            // 3) fulfill
            // 정의해둔 expectation이 충족되는 시점에 호출을 해서,
            // 비동기 작업을 마무리해도 된다고 알려준다.
            promise.fulfill()
        }
        
        // 2) wait
        // 비동기 작업이 끝날 때까지 기다리는, 타임아웃이 지나면 실패로 간주
        wait(for: [promise], timeout: 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

