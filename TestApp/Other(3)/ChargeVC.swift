//
//  ChargeVC.swift
//  TestApp
//
//  Created by Михаил Зайцев on 24/05/2019.
//  Copyright © 2019 Михаил Зайцев. All rights reserved.
//

import UIKit

class ChargeVC: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var FinishButton: UIButton!
    @IBOutlet weak var CheckButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = ""
        FinishButton.alpha = 0
    }
    
    func checkForCharging() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        if UIDevice.current.batteryState != .unplugged {
            statusLabel.text = "Good, batery is charging!"
            CheckButton.alpha = 0
            //print("Batery is charging")
        }
        else if UIDevice.current.batteryState == .unplugged {
            statusLabel.text = "Check the cable!"
            //print("Check the cable")
        }
    }
    
    @IBAction func CheckCargeButton(_ sender: Any) {
        checkForCharging()
        FinishButton.alpha = 1
    }
    
}
