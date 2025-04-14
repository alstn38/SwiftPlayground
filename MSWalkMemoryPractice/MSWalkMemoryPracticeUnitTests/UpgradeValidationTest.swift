//
//  UpgradeValidationTest.swift
//  MSWalkMemoryPracticeUnitTests
//
//  Created by 강민수 on 4/7/25.
//

import XCTest
@testable import MSWalkMemoryPractice

final class UpgradeValidationTest: XCTestCase {
    
    var sut: Validator!
    let validUser = User(
        email: "alstn38@naver.com",
        password: "123456",
        check: "123456"
    )
    
    let invalidUser = User(
        email: "asd123",
        password: "1234",
        check: "1111"
    )

    override func setUpWithError() throws {
        sut = Validator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testValidator_ValidID_ReturnTrue() {
        let value = validUser.email
        let valid = sut.isValidEmail(email: value)
        XCTAssertTrue(valid)
    }

    func testExample() throws {
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
