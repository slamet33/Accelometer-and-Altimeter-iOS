//
//  ViewControllerAltimeter.swift
//  Accelometer
//
//  Created by Qiarra on 11/07/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit
import CoreMotion

class ViewControllerAltimeter: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var altimeterSwitch: UISwitch!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let altimeter = CMAltimeter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if CMAltimeter.isRelativeAltitudeAvailable(){
            altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main) { (data, error) in
                self.label1.text = data?.relativeAltitude.stringValue
                self.label2.text = data?.pressure.stringValue
//                self.label1.text = String.init(format: "%.1fM", (data?.label1.floatValue)!)
//                self.label2.text = String.init(format: "%.2f hPA", (data?.label2.floatValue)!*10)
            }
        }
    
    }
    
    func startAltimeter() {
        
        print("Started relative altitude updates.")
        
        // Check if altimeter feature is available
        if (CMAltimeter.isRelativeAltitudeAvailable()) {
            
            self.activityIndicator.startAnimating()
            
            // Start altimeter updates, add it to the main queue
            self.altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main, withHandler: { (altitudeData:CMAltitudeData?, error:Error?) in
                
                if (error != nil) {
                    
                    // If there's an error, stop updating and alert the user
                    
                    self.altimeterSwitch.isOn = false
                    self.stopAltimeter()
                    
                    let alertView = UIAlertView(title: "Error", message: error!.localizedDescription, delegate: nil, cancelButtonTitle: "OK")
                    alertView.show()
                    
                } else {
                    
                    let altitude = altitudeData!.relativeAltitude.floatValue    // Relative altitude in meters
                    let pressure = altitudeData!.pressure.floatValue            // Pressure in kilopascals
                    
                    // Update labels, truncate float to two decimal points
                    self.label1.text = String(format: "%.02f", altitude)
                    self.label2.text = String(format: "%.02f", pressure)
                    
                }
                
            })
            
        } else {
            
            let alertView = UIAlertView(title: "Error", message: "Barometer not available on this device.", delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
            
        }
    }
    
    func stopAltimeter() {
        
        // Reset labels
        self.label1.text = ""
        self.label2.text = ""
        
        self.altimeter.stopRelativeAltitudeUpdates() // Stop updates
        
        self.activityIndicator.stopAnimating() // Hide indicator
        
        print("Stopped relative altitude updates.")
        
    }

    @IBAction func switchDidChange(_ senderSwitch: UISwitch) {
        if (senderSwitch.isOn == true) {
            self.startAltimeter()
        } else {
            self.stopAltimeter()
        }
    }
    
}
