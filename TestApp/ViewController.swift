//
//  ViewController.swift
//  TestApp
//
//  Created by Михаил Зайцев on 22/04/2019.
//  Copyright © 2019 Михаил Зайцев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var ColorModTouchT: UIButton!
    
    @IBAction func TestTouch(_ sender: UIButton) {
        print ("Tap")
    }
    /*
    func changeBackground (sender: UIButton, emoji: String) {
        sender.setTitle("", for: .normal)
        sender.backgroundColor = .orange
    } */
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.ColorModTouchT.setTitleColor(.green, for: .normal)
    }


}

