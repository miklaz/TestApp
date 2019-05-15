//
//  SoundVC.swift
//  TestApp
//
//  Created by Михаил Зайцев on 13/05/2019.
//  Copyright © 2019 Михаил Зайцев. All rights reserved.
//

import UIKit
import AVFoundation

class MSpeakVC: UIViewController {
    
    @IBOutlet weak var speakerStatus: UILabel!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var info: UILabel!
    
    
    let pianoSound = URL(fileURLWithPath: Bundle.main.path(forResource: "testSound2", ofType: "mp3")!)
    var audioPlayer = AVAudioPlayer()
//    var rand = Int.random(in: 1...4)
    
    
    @IBAction func PianoC(sender: AnyObject) {
        do {
                audioPlayer = try AVAudioPlayer(contentsOf: pianoSound)
                audioPlayer.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    @IBAction func Play(_ sender: UIButton) {
        PianoC(sender: AnyObject.self as AnyObject)
        self.speakerStatus.text = "Okay, if you heard the sound, then the main speaker works!"
        self.finishButton.alpha = 1
        self.info.alpha = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.speakerStatus.text = ""
        self.finishButton.alpha = 0
        
    }
    
    
    
}
