//
//  AppDelegate.swift
//  Assignment
//
//  Created by Vijay's Macbook on 21/08/20.
//  Copyright © 2020 Vijay. All rights reserved.
//
import UIKit
import Foundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.statusBarView?.backgroundColor = .black
        return true
    }
}

