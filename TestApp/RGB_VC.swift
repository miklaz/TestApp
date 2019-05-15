//
//  RGB_VS.swift
//  TestApp
//
//  Created by Михаил Зайцев on 11/05/2019.
//  Copyright © 2019 Михаил Зайцев. All rights reserved.
//

import UIKit

class RGB_VS: UIViewController {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var hideItems: UILabel!
    
    var colorOpt = [UIColor.red, UIColor.green, UIColor.blue]
    var colorOptItem = [UIColor.white, UIColor.black, UIColor.white]
    var isBleach = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.colorView.addGestureRecognizer(tapGestureRecognizer)
        // Do any additional setup after loading the view.
    }
    
    @objc func handleTap() {
        self.isBleach = !self.isBleach
        self.segmentControl.alpha = self.isBleach ? 0 : 1.0
        self.finishButton.alpha = self.isBleach ? 0 : 1.0
        self.hideItems.alpha = self.isBleach ? 0 : 1.0
    }
    
    @IBAction func changeColor(_ sender: Any) {
        self.colorView.backgroundColor = colorOpt[self.segmentControl.selectedSegmentIndex]
        self.segmentControl.tintColor = colorOptItem[self.segmentControl.selectedSegmentIndex]
        self.hideItems.textColor = colorOptItem[self.segmentControl.selectedSegmentIndex]
        self.finishButton.backgroundColor = colorOptItem[self.segmentControl.selectedSegmentIndex]
        self.finishButton.tintColor = colorOpt[self.segmentControl.selectedSegmentIndex]
    }
    

}
