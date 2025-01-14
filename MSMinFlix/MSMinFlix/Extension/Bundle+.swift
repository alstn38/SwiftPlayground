//
//  Bundle+.swift
//  MSMinFlix
//
//  Created by 강민수 on 1/14/25.
//

import Foundation

extension Bundle {
    
    var apiKey: String? {
        guard let filePath = Bundle.main.path(forResource: "SecureAPIKeys", ofType: "plist"),
              let plistDict = NSDictionary(contentsOfFile: filePath) else {
            return nil
        }
        
        guard let value = plistDict.object(forKey: "API_KEY") as? String else {
            return nil
        }
        
        return value
    }
}
