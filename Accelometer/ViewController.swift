//
//  ViewController.swift
//  Accelometer
//
//  Created by Qiarra on 11/07/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    let motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startAccelerometer()
        
        
    }
    
    func startAccelerometer() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
                
                if let dataColor = data {
//                    print(data)
                    self.xLabel.text = String(format: "%.2f", dataColor.acceleration.x)
//                    if((dataColor.acceleration.x > 0.1)) {
//                        self.colorView.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: CGFloat(dataColor.acceleration.x))
//                    }
                    self.colorView.backgroundColor = UIColor(red: CGFloat(dataColor.acceleration.x), green: CGFloat(dataColor.acceleration.y), blue: CGFloat(dataColor.acceleration.z), alpha: 1)
                    print(self.colorView.backgroundColor)
                }
            }
        }
    }

}

