//
//  CustomApiManager.swift
//  Verkoop
//
//  Created by Vijay's Macbook on 21/08/20.
//  Copyright © 2020 MobileCoderz. All rights reserved.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct StatusCode {
    static let success = 200
    static let noDataFound = 400
    static let pageNotFound = 404
    static let unauthenticated = 401
    static let alreadyReported = 208
    static let resourceCreated = 201
}

class APIManager {
    
    typealias APISuccess = (_ resposeData : Any, _ success: Bool) -> Void
    typealias APIFailure = (_ errorString: String) -> Void
    typealias DiplayProgress = (_ progress: Any) -> Void
    typealias paramsJSON = [String:Any]
    
    class func fetchDataFromWeb<T: Decodable>(apiQueue:DispatchQueue , endPoint: String, completion: @escaping (T?, Error?) -> ()) {
        let url = URL(string: ConfigurationManager.shared().applicationEndPoint() + endPoint)
        apiQueue.async {
            URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    completion(nil, error)
                    return
                }
                guard let dataObject = data else {
                    completion(nil, NSError(domain: "DATA ERROR", code: 404, userInfo: ["localizedDescription": "NO DATA FOUND"]))
                    return
                }
                
                guard let urlResponse = response as? HTTPURLResponse else {
                    completion(nil, NSError(domain: "INVALID RESPONSE", code: 500, userInfo: ["localizedDescription": "INVALID RESPONSE FROM SERVER"]))
                    return
                }
                print("Total Data received: \(dataObject) Bytes")
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: dataObject, options: [])
                    self.prettyPrint(json: jsonObject, statusCode: 200)
                } catch let serializationError {
                    DebugLogging.log(serializationError.localizedDescription)
                }
                
                if urlResponse.statusCode == StatusCode.success || urlResponse.statusCode == StatusCode.resourceCreated {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    do {
                        let object = try decoder.decode(T.self, from: dataObject)
                        completion(object, nil)
                    } catch let DecodingError.typeMismatch(type, context) {
                        print("Type '\(type)' Mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                        completion(nil, NSError(domain: "Mismatch", code: 200, userInfo: [NSLocalizedDescriptionKey: "DATA TYPE MISMATCH"]))
                    } catch let DecodingError.keyNotFound(key, context){
                        print("Mismatch:", context.debugDescription)
                        print("key:", key)
                        completion(nil, NSError(domain: "Key Missing", code: 200, userInfo: [NSLocalizedDescriptionKey: "KEY IS MISSING"]))
                    } catch {
                        print("Parsing Error \(error)")
                        completion(nil, NSError(domain: "Invalid Data", code: 200, userInfo: [NSLocalizedDescriptionKey: "INVALID DATA FORMAT"]))
                    }
                } else {
                    completion(nil, NSError(domain: "Invalid Response", code: urlResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "INVALID RESPONSE FROM SERVER"]))
                }
            }).resume()
        }
    }
    
    //MARK:-  Get Header
    //MARK:-
    
    func getURLRequestWithHeader(_ urlString: String) -> URLRequest {
        var urlRequest = URLRequest(url: URL(string: urlString)!)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
    
    func convertDictToJSONData(_ dict: [String: Any]) -> Data {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            if let dictFromJSON = decoded as? [String:String] {
                print(dictFromJSON)
            }
            return jsonData
        } catch {
            print(error.localizedDescription)
            return Data()
        }
    }
    
    class func prettyPrint(json: Any, statusCode: Int) {
        if let json = json as? [String: Any] {
            print(prettyPrintDict(with: json))
        } else if let json = json as? [Any] {
            print(prettyPrintArray(with: json))
        }
    }
    
    private class func prettyPrintArray(with json: [Any]) -> String {
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let string = String(data: data, encoding: String.Encoding.utf8)
            if let string  = string {
                return string
            }
        } catch {
            print(error.localizedDescription)
        }
        return ""
    }
    
    private class func prettyPrintDict(with json: [String : Any]) -> String {
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let string = String(data: data, encoding: String.Encoding.utf8)
            if let string  = string {
                return string
            }
        } catch {
            print(error.localizedDescription)
        }
        return ""
    }
}
