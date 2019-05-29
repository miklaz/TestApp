//
//  GyroscopeVC.swift
//  TestApp
//
//  Created by Михаил Зайцев on 24/05/2019.
//  Copyright © 2019 Михаил Зайцев. All rights reserved.
//

import UIKit

class GyroscopeVC: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var finishButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = "Shake your devise"
        finishButton.alpha = 0
        self.becomeFirstResponder()
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            statusLabel.text = "Good, gyroscope works!"
            finishButton.alpha = 1
            print("shake")
        }
    }

}
