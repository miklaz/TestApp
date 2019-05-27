//
//  FaceID_VC.swift
//  TestApp
//
//  Created by Михаил Зайцев on 15/05/2019.
//  Copyright © 2019 Михаил Зайцев. All rights reserved.
//

import UIKit
import LocalAuthentication

class FaceID_VC: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tapForTestButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.statusLabel.text = ""
        self.finishButton.alpha = 0
    }
    
    
    @IBAction func touchID(_ sender: Any) {
        let context:LAContext = LAContext ()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "We want to login with your finger print or face", reply: { (wasCorrrct, error) in
                if wasCorrrct {
                    print("Correct")
                    DispatchQueue.main.async {
                    self.statusLabel.text = "Good, TouchID/FaceID works!"
                    self.finishButton.alpha = 1
                    self.tapForTestButton.alpha = 0
                    }
                }
                else {
                    print("Incorrect")
                    DispatchQueue.main.async {
                    self.statusLabel.text = "Oops... it looks like TouchID/FaceID doesn't work :(  Maybe again?"
                    self.finishButton.alpha = 1
                    }
                }
            })
        }
        else {
            print ("Doesn't work")
            self.statusLabel.text = "Oops... it looks like TouchID/FaceID doesn't work :("
            self.finishButton.alpha = 1
        }
    }
    
}

