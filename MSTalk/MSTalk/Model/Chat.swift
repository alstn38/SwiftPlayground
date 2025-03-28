//
//  Chat.swift
//  MSTalk
//
//  Created by 강민수 on 1/10/25.
//

import Foundation

struct Chat {
    let user: User
    let date: String
    let message: String
    
    var isDateSeparator: Bool {
        return user == .dateSeparator
    }
    
    var isUser: Bool {
        return user == .user
    }
}
