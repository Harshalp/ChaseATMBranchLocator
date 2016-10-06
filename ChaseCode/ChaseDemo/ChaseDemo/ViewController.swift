//
//  ViewController.swift
//  ChaseDemo
//
//  Created by harshal_s on 10/3/16.
//  Copyright © 2016 Harshal Pandhe. All rights reserved.
//

import UIKit
import ChaseDemoKit

class ViewController: UIViewController {

    @IBAction func showChase(_ sender: AnyObject) {
        
        let chaseMapView = ChaseATMBranchController(googleKey: Constants.google_api_key)
        
        self.present(chaseMapView, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

