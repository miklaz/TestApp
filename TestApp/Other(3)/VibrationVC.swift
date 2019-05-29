//
//  VibrationVC.swift
//  TestApp
//
//  Created by Михаил Зайцев on 24/05/2019.
//  Copyright © 2019 Михаил Зайцев. All rights reserved.
//

import UIKit
import AudioToolbox

class VibrationVC: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var finishButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = "Tap the button for check"
        finishButton.alpha = 0
    }
    
    @IBAction func vibration(_ sender: Any) {
        statusLabel.text = "Okay, if you heard the sound, then the main speaker works!"
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        //let generator = UIImpactFeedbackGenerator(style: .heavy)
        //generator.impactOccurred()
        //UINotificationFeedbackGenerator().notificationOccurred(.success)
        finishButton.alpha = 1
    }
    
}
