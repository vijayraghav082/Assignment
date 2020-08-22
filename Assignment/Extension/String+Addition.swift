//
//  String+Addition.swift
//  Assignment
//
//  Created by Mobilecoderz on 22/08/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import UIKit
import Foundation

extension String {
    func isValidSearchText() -> Bool {
        let nameRegEx = "^[ A-z0-9-_]*[ A-z0-9-_][ A-z0-9-_]*"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: self)
    }
}


enum AppStoryboard : String {
    
    case main = "Main"
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}
