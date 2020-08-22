//
//  UserDefault+Addition.swift
//  Assignment
//
//  Created by Mobilecoderz on 22/08/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import UIKit

extension UserDefaults {
    func setSearchKeyword(_ keyword: String) {
        if var value = value(forKey: UserDefaultsKeys.kSearchKeywordArray) as? [String] {
            if !value.contains(keyword) {
                if value.count >= 10 {
                    value.removeLast()
                }
                value.insert(keyword, at: 0)
                set(value, forKey: UserDefaultsKeys.kSearchKeywordArray)                
            }
        } else {
            set([keyword], forKey: UserDefaultsKeys.kSearchKeywordArray)
        }
    }
    
    func getSearchKeyword() -> [String] {
        return value(forKey: UserDefaultsKeys.kSearchKeywordArray) as? [String] ?? []
    }
}
