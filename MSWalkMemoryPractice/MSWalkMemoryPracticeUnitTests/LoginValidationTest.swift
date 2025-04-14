//
//  LoginValidationTest.swift
//  MSWalkMemoryPracticeUnitTests
//
//  Created by 강민수 on 4/7/25.
//

import XCTest
@testable import MSWalkMemoryPractice

final class LoginValidationTest: XCTestCase {

    var sut: LoginViewController!
    
    /// 테스트의 독립성 고유성 일관성을 유지시켜줄 수 있다.
    override func setUpWithError() throws {
        /// 스토리보드에서 만들어졌다면, 미리 스토리보드를 가져오는 작업이 필요하다.
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        sut = vc
        sut.loadViewIfNeeded() // 뷰를 띄워주는 메서드
        sut = LoginViewController()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    /// id에 조건에 문제가 없는지 확인하는 것
    func testLoginViewController_ValidID_ReturnTrue() throws {
        // Given
        let value = "alstn38@naver.com"
        
        // When
        sut.idTextField.text = value
        
        //Then
        XCTAssertTrue(sut.isValidID(), "@가 없거나 6글자 미만이다.")
    }
    
    // @가 없으면 실패하는 상황에 대해서 테스트를 하고 싶음.
    // 실패 케이스를 테스트 하고 싶음
    // 테스트 결과는 성공으로 나오도록 해야한다.
    func testLoginViewController_ValidID_ReturnFalse() throws {
        // Given
        let value = "alstn38"
        
        // When
        sut.idTextField.text = value
        
        //Then
        XCTAssertFalse(sut.isValidID())
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

