//
//  ForceTouchVC.swift
//  TestApp
//
//  Created by Михаил Зайцев on 12/05/2019.
//  Copyright © 2019 Михаил Зайцев. All rights reserved.
//

import UIKit

class ForceTouchVC: UIViewController {

    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var finish: UIButton!
    
    let redView = UIView()
    lazy var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
    lazy var forceTouchGestureRecognizer = ForceTouchGestureRecognizer(target: self, action: #selector(forceTouchHandler))
    var isBleach = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.finish.alpha = 0
        redView.backgroundColor = .red
        redView.addGestureRecognizer(tapGestureRecognizer)
        
        view.addSubview(redView)
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        redView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        redView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        redView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            redView.addGestureRecognizer(forceTouchGestureRecognizer)
        } else  {
            // When force touch is not available, remove force touch gesture recognizer.
            // Also implement a fallback if necessary (e.g. a long press gesture recognizer)
            redView.removeGestureRecognizer(forceTouchGestureRecognizer)
        }
    }
    
    @objc func tapHandler(_ sender: UITapGestureRecognizer) {
        print("Tap triggered")
        self.status.text = "Oops... it looks like 3D Touch doesn't work :("
        self.finish.alpha = 1
    }
    
    @objc func forceTouchHandler(_ sender: ForceTouchGestureRecognizer) {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        self.status.text = "Good, 3D Touch works!"
        print("Force touch triggered")
        redView.alpha = 0
        self.finish.alpha = 1
    }

}
