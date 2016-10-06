//
//  ChaseLocationManager.swift
//  ChaseATMLocator
//
//  Created by harshal_s on 9/27/16.
//  Copyright © 2016 Harshal Pandhe. All rights reserved.
//

import UIKit
import CoreLocation

protocol ChaseLocationManagerDelegate {
 
    func getCordinates(location: CLLocation) -> ()
}

//This class will get the current location.
class ChaseLocationManager:NSObject, CLLocationManagerDelegate {
    
    var manager:CLLocationManager
    var delegate:ChaseLocationManagerDelegate!
    
    
    override init() {
        
        manager = CLLocationManager()
        manager.distanceFilter = 50
        manager.desiredAccuracy = 50
        
        super.init()
    }
    
    /**
     This method will start updating the user location. 
     If user is using an app for the first time then it will prompt for authorization permission.
     **/
    func requestLocationPermission() {
        
        manager.delegate = self
        switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways,.authorizedWhenInUse:
                manager.startUpdatingLocation()
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case  .restricted,.denied:break
        }
    }
    
    // MARK: - CLLocationManagerDelegate methods
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last!
        
        //Sending current location by calling delegate method
        delegate.getCordinates(location: location)
    }
    
    func stopUpdation() {
        
        manager.stopUpdatingLocation()
    }
}
