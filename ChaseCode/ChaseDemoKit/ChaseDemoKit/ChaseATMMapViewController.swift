//
//  ChaseATMMapViewController.swift
//  ChaseATMLocator
//
//  Created by harshal_s on 9/26/16.
//  Copyright © 2016 Harshal Pandhe. All rights reserved.
//

import UIKit
import GoogleMaps

//This class is an entry point of framework. It will display navigation controller with google map view.
public class ChaseATMBranchController: UINavigationController {
    
    public init(googleKey:String) {
    
        //Register google api key
        GMSServices.provideAPIKey(googleKey)
        
        let viewController = ChaseATMMapViewController()
        
        super.init(rootViewController: viewController)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
}


//This class opens google map view with annotations. 
class ChaseATMMapViewController: UIViewController, ChaseLocationManagerDelegate, ChaseATMServiceManagerDelegate, GMSMapViewDelegate {
    
    var mapView: GMSMapView!
    
    var chaseLocationManager: ChaseLocationManager!
    
    override func loadView() {
        
        //Display google map.
        let camera = GMSCameraPosition.camera(withLatitude: 0.0, longitude: 0.0, zoom: 0.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        view = mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Find the current location
        chaseLocationManager = ChaseLocationManager()
        chaseLocationManager.delegate = self
        chaseLocationManager.requestLocationPermission()
        
        self.mapView.delegate = self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Close", comment: ""), style: .plain, target: self, action: #selector(closeTapped))
    }
    
    func closeTapped() {
        
        self.navigationController?.dismiss(animated: true, completion: {
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - ChaseLocationManagerDelegate method which provides current latitude and longitude.
    func getCordinates(location: CLLocation) {
        
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        chaseLocationManager.stopUpdation()
        
        if Reachability.isConnectedToNetwork() {
            
            ChaseATMServiceManager.sharedInstance.delegate = self
            ChaseATMServiceManager.sharedInstance.getNearbyChaseATM(lat: "\(location.coordinate.latitude)", lng: "\(location.coordinate.longitude)")
        }
        else {
            
            let alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("Please connect to the internet.", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: - ChaseATMServiceManagerDelegate method which provides json disctionary with all chase atm's and branches.
    func nearByChaseATMAndBranches(dicATM: NSDictionary!, error: NSError!) {
    
        if let err = error as NSError! {
            
            let alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: err.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            let locations = dicATM["locations"] as! NSArray!
            
            for location in locations! {
                
                let atmBranch = AtmBranch(data: location as! Dictionary<String, AnyObject>)
                
                let marker = GMSMarker(position: atmBranch.coordinate)
                marker.title = atmBranch.name
                marker.snippet = atmBranch.locType
                marker.icon = GMSMarker.markerImage(with: UIColor.blue)
                marker.userData = atmBranch
                
                marker.map = mapView
                
                
            }
        }
    }
    
    /**
     This method is called when user taps on map marker.
     
     It displays detail view with Chase ATM/Branch
     **/
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
        let atmBranch = marker.userData as! AtmBranch
        
        let atmDetailView = ChaseATMDetailViewController()
        atmDetailView.atmBranch = atmBranch
        
        self.show(atmDetailView, sender: self)
    }
}

