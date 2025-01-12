//
//  User.swift
//  MSTalk
//
//  Created by 강민수 on 1/10/25.
//

import Foundation

enum User: String {
    case hue = "Hue"
    case jack = "Jack"
    case bran = "Bran"
    case den = "Den"
    case user //본인
    case other_friend = "내옆자리의앞자리에개발잘하는친구"
    case simsim = "심심이"
    case dateSeparator //날짜 구분선 용
    
    var profileImage: String {
        return rawValue
    }
}
