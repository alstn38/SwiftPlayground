//
//  SampleTest.swift
//  MSWalkMemoryPracticeUnitTests
//
//  Created by 강민수 on 4/7/25.
//

import XCTest
@testable import MSWalkMemoryPractice

final class SampleTest: XCTestCase {

    var number: Int?
    
    /// 초기화
    override func setUpWithError() throws {
        
    }

    /// nil
    override func tearDownWithError() throws {
        
    }
    
    /// setUpWithError() -> testPlus() -> tearDownWithError()
    func testPlus() throws {
        print(#function)
        let a = 2
        let b = 2
        
        XCTAssertEqual(a + b, number, "덧셈 결과가 같지 않음")
    }
    
    func testMinus() throws {
        print(#function)
        let a = 5
        let b = 2
        XCTAssertEqual(a - b, number, "뺄셈 결과가 같지 않음")
    }

    /// 앞에 test를 붙인다..
    func testExample() throws {
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
