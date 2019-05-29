//
//  GPS_VC.swift
//  TestApp
//
//  Created by Михаил Зайцев on 14/05/2019.
//  Copyright © 2019 Михаил Зайцев. All rights reserved.
//

import UIKit
import MapKit

class GPS_VC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.finishButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        checkLocationEnabled()
    }
    
    func checkLocationEnabled () {
        if CLLocationManager.locationServicesEnabled() {
            setupManager ()
            checkAutorization()        }
        else {
            showAlertLocation (title: "You have geolocation turned off", message: "Want to turn on?", url: URL(string: "App-Precfs:root=LOCATION_SERVICES"))
        }
    }
    
    func setupManager () {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func checkAutorization () {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            break
        case .denied:
            showAlertLocation(title: "You have banned the use of geolocation", message: "Want to change this?", url: URL(string: UIApplication.openSettingsURLString))
            break
        case .restricted:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            print ("Oops...")
        }
    }
    
    func showAlertLocation (title: String, message:String?,url:URL?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (alert) in
            if let url = url{
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        let cancelAction = UIAlertAction (title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func magic () {
        self.yesButton.alpha = 0
        self.noButton.alpha = 0
        self.finishButton.alpha = 1
    }
    
    @IBAction func sayYes(_ sender: Any) {
        magic()
        self.statusLabel.text = "Good, GPS is works!"
    }
    @IBAction func sayNooooo(_ sender: Any) {
        magic()
        self.statusLabel.text = "Oops... it looks like GPS doesn't work :("
    }
    
}


extension GPS_VC:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 300, longitudinalMeters: 300)
            mapView.setRegion(region, animated: true)
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAutorization()
    }
    
}

