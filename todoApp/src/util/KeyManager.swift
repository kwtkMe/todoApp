//
//  KeyManager.swift
//  todoApp
//
//  Created by RIVER on 2019/05/20.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import Foundation

struct KeyManager {
    
    // KeyInfo.plistを取得
    private let keyFilePath = Bundle.main.path(forResource: "KeyInfo",
                                               ofType: "plist")
    
    func getKeys() -> NSDictionary? {
        guard let keyFilePath = keyFilePath else {
            return nil
        }
        return NSDictionary(contentsOfFile: keyFilePath)
    }
    
    func getValue(key: String) -> AnyObject? {
        guard let keys = getKeys() else {
            return nil
        }
        return keys[key]! as AnyObject
    }
}

