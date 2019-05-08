//
//  ForceTouchVC.swift
//  TestApp
//
//  Created by Михаил Зайцев on 24/04/2019.
//  Copyright © 2019 Михаил Зайцев. All rights reserved.
//

import UIKit

class ForceTouchVC: UIViewController {

    //@IBOutlet weak var scaleView: ScaleView!
    
    //@IBOutlet weak var forceLabel: UILabel!
    
    //@IBOutlet weak var grammLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // forceLabel.text = "0% force"
       // grammLabel.text = "0 грамм" */
    }
    
   /* override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first { // 1
            if #available(iOS 9.0, *) { // 2
                if traitCollection.forceTouchCapability == UIForceTouchCapability.available { // 3
                    if touch.force >= touch.maximumPossibleForce { // 4
                        forceLabel.text = "100%+ force"
                        grammLabel.text = "385 грамм"
                    } else {
                        
                        let force = (touch.force / touch.maximumPossibleForce) * 100 // 5
                        let grams = force * 385 / 100 // 6
                        let roundGrams = Int(grams) // 7
                        
                        forceLabel.text = "\(Int(force))% force" // 8
                        grammLabel.text = "\(roundGrams) грамм"
                        
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        forceLabel.text = "0% force"
       grammLabel.text = "0 грамм"
    } */

}
