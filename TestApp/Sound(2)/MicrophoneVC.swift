//
//  MicrophoneVC.swift
//  TestApp
//
//  Created by Михаил Зайцев on 13/05/2019.
//  Copyright © 2019 Михаил Зайцев. All rights reserved.
//

import UIKit
import AVFoundation

class MicrophoneVC: UIViewController, AVAudioRecorderDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var recSession:AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var numberOfRecords:Int = 0
    
    var player:AVAudioPlayer = AVAudioPlayer()
    

    @IBOutlet weak var buttonLabel: UIButton!
    @IBOutlet weak var myTableView: UITableView!
    
    @IBAction func record(_ sender: Any) {
        if audioRecorder == nil {
            numberOfRecords += 1
            let filename = getDirectory().appendingPathComponent("\(numberOfRecords).m4a")
            
            let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
            //start rec
            do
            {
                audioRecorder = try AVAudioRecorder(url: filename, settings: settings)
                audioRecorder.delegate = self
                audioRecorder.record()
                
                buttonLabel.setTitle("Stop Recording", for: .normal)
            }
            catch
            {
                displayAlert(title: "Ups!", message: "Recording faild")
            }
        }
        else {
            //stop rec
            audioRecorder.stop()
            audioRecorder = nil
            
            UserDefaults.standard.set(numberOfRecords, forKey: "myNumber")
            myTableView.reloadData()
            
            buttonLabel.setTitle("Start Recording", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start up Session
        recSession = AVAudioSession.sharedInstance()
        
        if let number:Int = UserDefaults.standard.object(forKey: "myNumber") as? Int {
            numberOfRecords = number
        }
        
        AVAudioSession.sharedInstance().requestRecordPermission { (hasPermission) in
            if hasPermission {
                print ("ACCEPTED")
            }
        }
        
        // play/pause
        /*
        do
        {
            let audioPath = getDirectory().appendingPathComponent("\(indexPath.row + 1).m4a")
            try player = AVAudioPlayer(contentsOf: NSURL, fileURLWithPath: audioPath!) as URL)
        }
        catch
        {
            
        }
        */
    }
    
    //Function that gets path to directory
    func getDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory
    }
    
    //Func that displays an alert
    func displayAlert (title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //Setting up table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRecords
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(indexPath.row + 1) //
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let path = getDirectory().appendingPathComponent("\(indexPath.row + 1).m4a")
        
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: path)
            audioPlayer.play()
        }
        catch
        {
            
        }
    }
    
}


    /*
    //Outlets
    @IBOutlet weak var recordingTimeLabel: UILabel!
    
    //Variables
    var audioRecorder: AVAudioRecorder!
    var meterTimer:Timer!
    var isAudioRecordingGranted: Bool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSessionRecordPermission.granted:
            isAudioRecordingGranted = true
            break
        case AVAudioSessionRecordPermission.denied:
            isAudioRecordingGranted = false
            break
        case AVAudioSessionRecordPermission.undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.isAudioRecordingGranted = true
                    } else {
                        self.isAudioRecordingGranted = false
                    }
                }
            }
            break
        default:
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        audioRecorder = nil
    }
    
    //MARK:- Audio recorder buttons action.
    @IBAction func audioRecorderAction(_ sender: UIButton) {
        
        if isAudioRecordingGranted {
            
            //Create the session.
            let session = AVAudioSession.sharedInstance()
            
            do {
                //Configure the session for recording and playback.
                try session.setCategory(AVAudioSession.Category.playAndRecord, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
                try session.setActive(true)
                //Set up a high-quality recording session.
                let settings = [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 44100,
                    AVNumberOfChannelsKey: 2,
                    AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                ]
                //Create audio file name URL
                let audioFilename = getDocumentsDirectory().appendingPathComponent("audioRecording.m4a")
                //Create the audio recording, and assign ourselves as the delegate
                audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
                audioRecorder.delegate = self
                audioRecorder.isMeteringEnabled = true
                audioRecorder.record()
                meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(self.updateAudioMeter(timer:)), userInfo:nil, repeats:true)
            }
            catch let error {
                print("Error for start audio recording: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func stopAudioRecordingAction(_ sender: UIButton) {
        
        finishAudioRecording(success: true)
        
    }
    
    func finishAudioRecording(success: Bool) {
        
        audioRecorder.stop()
        audioRecorder = nil
        meterTimer.invalidate()
        
        if success {
            print("Recording finished successfully.")
        } else {
            print("Recording failed :(")
        }
    }
    
    @objc func updateAudioMeter(timer: Timer) {
        
        if audioRecorder.isRecording {
            let hr = Int((audioRecorder.currentTime / 60) / 60)
            let min = Int(audioRecorder.currentTime / 60)
            let sec = Int(audioRecorder.currentTime.truncatingRemainder(dividingBy: 60))
            let totalTimeString = String(format: "%02d:%02d:%02d", hr, min, sec)
            recordingTimeLabel.text = totalTimeString
            audioRecorder.updateMeters()
        }
    }
    
    func getDocumentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    //MARK:- Audio recoder delegate methods
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if !flag {
            finishAudioRecording(success: false)
        }
    }
}
*/
