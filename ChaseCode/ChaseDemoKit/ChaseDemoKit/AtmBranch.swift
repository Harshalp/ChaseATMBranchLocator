//
//  AtmBranch.swift
//  ChaseATMLocator
//
//  Created by harshal_s on 9/27/16.
//  Copyright © 2016 Harshal Pandhe. All rights reserved.
//


import UIKit
import CoreLocation

//  This class will hold ATM and Branch data fetched from server.
class AtmBranch: NSObject {

    var state:String
    var locType:String
    var address:String
    var city:String
    var zip:String
    var name:String
    var lat:String
    var long:String
    var label:String?
    var coordinate:CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(long)!)
        }
    }
    
    init(state:String, locType:String, address:String, city:String, zip:String, name:String, lat:String, long:String, label:String) {
        
        self.state = state
        self.locType = locType
        self.address = address
        self.city = city
        self.zip = zip
        self.name = name
        self.lat = lat
        self.long = long
        self.label = label
        
        super.init()
    }
    
    // This method will take json dictionary as a parameter to initize the object.
    convenience init(data:Dictionary<String, AnyObject>) {
        
        self.init(state:data["state"] as! String, locType:data["locType"] as! String, address:data["address"] as! String, city:data["city"] as! String, zip:data["zip"] as! String, name:data["name"] as! String, lat: data["lat"] as! String, long:data["lng"] as! String, label:data["label"] as! String)
    }
}
