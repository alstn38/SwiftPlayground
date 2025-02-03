//
//  Bundle+.swift
//  MSMap
//
//  Created by 강민수 on 2/3/25.
//

import Foundation

extension Bundle {
    
    var mainURL: String {
        guard let filePath = Bundle.main.path(forResource: "SecureAPIKeys", ofType: "plist"),
              let plistDict = NSDictionary(contentsOfFile: filePath) else {
            fatalError("Couldn't find file SecureAPIKeys.plist")
        }
        
        guard let value = plistDict.object(forKey: "MAIN_URL") as? String else {
            fatalError("Couldn't find key 'API_Key' in SecureAPIKeys.plist")
        }
        
        return value
    }
    
    var apiKey: String {
        guard let filePath = Bundle.main.path(forResource: "SecureAPIKeys", ofType: "plist"),
              let plistDict = NSDictionary(contentsOfFile: filePath) else {
            fatalError("Couldn't find file SecureAPIKeys.plist")
        }
        
        guard let value = plistDict.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_Key' in SecureAPIKeys.plist")
        }
        
        return value
    }
}
