//
//  Validator.swift
//  MSWalkMemoryPractice
//
//  Created by 강민수 on 4/7/25.
//

import Foundation

struct User {
    let email: String
    let password: String
    let check: String
}

struct Validator {
    
    func isValidEmail(email: String) -> Bool {
        return email.contains("@") && email.count >= 6
    }
    
    func isValidPassword(password: String) -> Bool {
        return password.count >= 6 && password.count < 10
    }
    
    func isEqualPassword(password: String, check: String) -> Bool {
        return password == check
    }
    
}
