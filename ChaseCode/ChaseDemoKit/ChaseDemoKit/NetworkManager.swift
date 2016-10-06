//
//  NetworkManager.swift
//  ChaseATMLocator
//
//  Created by harshal_s on 9/27/16.
//  Copyright © 2016 Harshal Pandhe. All rights reserved.
//

import UIKit
import SystemConfiguration

//Network manager class handles network operations.
class NetworkManager: NSObject {
    
    static let sharedInstance = NetworkManager()
    
    typealias CompletionHandler = (_ jsonDictionary:NSDictionary?, _ error: NSError?) -> Void
    
    /**
     Performs get request. Takes string url path as a parameter.
     
     It will retrive response parse the json and return it using completion handler.
     **/
    func makeHTTPGetRequest(path: String, onCompletion: @escaping CompletionHandler) {
        
        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if let jsonData = data {
    
                do {
                    //It will parse the json data and convert it into dictionary
                    let dicObj = try JSONSerialization.jsonObject(with: jsonData, options: []) as! NSDictionary
                    
                    print(dicObj);
                    
                    DispatchQueue.main.async {
                        
                        onCompletion(dicObj, nil)
                    }
                    
                } catch let error as NSError {
                    
                    print("json error: \(error.localizedDescription)")
                    
                    onCompletion(nil, error)
                }
                
            } else {
                
                onCompletion(nil, error as NSError?)
            }
        })
        task.resume()
    }
}

//This class checks network reachability.
public class Reachability {
    
    /**
     This method will check whether network is available or not.
     
     Method return Boolean value by checking network rechability.
     **/
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}

