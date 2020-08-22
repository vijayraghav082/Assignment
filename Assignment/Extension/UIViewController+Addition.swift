//
//  UIViewController+Extension.swift
//  Verkoop
//
//  Created by Vijay's Macbook on 21/08/20.
//  Copyright © 2020 MobileCoderz. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    func handleSuccess<T: Decodable> (data: Any) -> T? {
        do {
            let data = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let data = try decoder.decode(T.self, from: data)
                return data
            } catch let DecodingError.typeMismatch(type, context) {
                print("Type '\(type)' Mismatch: \(context.debugDescription)")
                print("codingPath: \(context.codingPath)")
            } catch let DecodingError.keyNotFound(key, context){
                print("Mismatch: \(context.debugDescription)")
                print("key: \(key)")
            } catch {
                print("Parsing Error \(error)")
            }
            
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func handleFailure(error: Error?){
        if let error = error {
            print(error.localizedDescription)
        }
    }
    
    func getMainQueue(completion: @escaping ()->()) {
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func delay(time:TimeInterval,completionHandler: @escaping ()->()) {
        let when = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: when) {
            completionHandler()
        }
    }
}
