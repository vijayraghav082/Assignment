//
//  Constants.swift
//  Assignment
//
//  Created by Vijay's Macbook on 21/08/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import UIKit
import Foundation

let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height
let kUserDefault = UserDefaults.standard

//MARK:- Cell Identifiers
//MARK:-

struct CellIdentifier {
    static let ASImageCell = "ASImageCell"
    static let ASIndicatorCell = "ASIndicatorCell"
    static let ASSuggestionCell = "ASSuggestionCell"
    static let ASImagePreviewCell = "ASImagePreviewCell"
}

struct UserDefaultsKeys {
    static let kSearchKeywordArray = "searchKeywords"
}

struct ValidationMessage {
    static let invalidSearchTag = "Invalid Search Text."
}

struct DebugLogging {
    static func log(_ message: Any?) {
        print(message ?? "Either Value is nil or in invalid format.")
    }
}
