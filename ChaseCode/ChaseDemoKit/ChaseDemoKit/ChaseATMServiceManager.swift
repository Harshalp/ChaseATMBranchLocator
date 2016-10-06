//
//  ChaseATMServiceManager.swift
//  ChaseDemoKit
//
//  Created by harshal_s on 10/4/16.
//  Copyright © 2016 Harshal Pandhe. All rights reserved.
//

import UIKit

protocol ChaseATMServiceManagerDelegate {
    
    func nearByChaseATMAndBranches(dicATM: NSDictionary!, error: NSError!) -> ()
}

//Send chase specific request to server.
class ChaseATMServiceManager: NSObject {

    static let sharedInstance = ChaseATMServiceManager()
    var delegate:ChaseATMServiceManagerDelegate!
    
    /**
     Request nearby chase ATM's and Branches using current latitude and longitude.
     **/
    func getNearbyChaseATM(lat:String, lng:String) {
        
        let route = "\(Constants.google_service_url)?lat=\(lat)&lng=\(lng)"
        
        NetworkManager.sharedInstance.makeHTTPGetRequest(path: route) { (jsonDictionary: NSDictionary?, error: NSError?) in
            
            self.delegate.nearByChaseATMAndBranches(dicATM: jsonDictionary, error: error);
        }
    }
}
