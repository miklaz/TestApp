//
//  FlashVC.swift
//  TestApp
//
//  Created by Михаил Зайцев on 24/05/2019.
//  Copyright © 2019 Михаил Зайцев. All rights reserved.
//

import UIKit
//import
import AVFoundation


class FlashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    func flashlight() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else{
            return
        }
        if (device.hasTorch) {
            do {
                try device.lockForConfiguration()
                if (device.torchMode == .on) {
                    device.torchMode = .off
                }
                else {
                    device.torchMode = .on
                }
                device.unlockForConfiguration()
                }
            catch {
                //print("Torch could not be used")
                print(error)
            }
        }
        else {
            //print("Torch is not available")
        }
    }

    @IBAction func flashActive(_ sender: Any) {
        flashlight()
    }
    
    

}
