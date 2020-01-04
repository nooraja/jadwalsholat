//
//  SplashController.swift
//  JadwalSholat
//
//  Created by NOOR on 25/11/19.
//  Copyright © 2019 NOOR. All rights reserved.
//

import UIKit
import CoreLocation

class SplashController: UIViewController, CLLocationManagerDelegate {
    
    var locManager = CLLocationManager()
    var province: String?
    var currentLocation: CLLocation!
    var isUpdatingLocation = true
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Futura", size: 100)
        label.textAlignment = .center
        label.text = "JS"
        label.textColor = .telegramBlue
        label.textAlignment = .center
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Futura", size: 34)
        label.textAlignment = .center
        label.text = "Jam Sholat"
        label.textColor = .telegramBlue
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        
        titleLabel.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 120)
        titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        subtitleLabel.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 50)
        subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        locManager.delegate = self
        locManager.requestWhenInUseAuthorization()
        locManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if #available(iOS 9, *) {
            locManager.allowsBackgroundLocationUpdates = false
        }
        locManager.stopUpdatingLocation()
    }
}

extension SplashController {
    func stopLocationManager() {
        locManager.stopUpdatingLocation()
    }
    
    func getAddressFromLatLon(latitude: String, longitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(latitude)")!
        let lon: Double = Double("\(longitude)")!
        
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            { [weak self] (placemarks, error)  in
                if (error != nil) {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                
                guard let pm = placemarks else { return }
                
                if pm.count > 0 {
                    
                    self?.province = placemarks?.first?.administrativeArea
                    
                    guard let province = self?.province else {
                        return
                    }

                    let viewController = JadwalController(viewModel: JadwalViewModel(networkModel: JadwalNetworkModel()))
                    viewController.modalPresentationStyle = .fullScreen
                    self?.present(viewController, animated: false, completion: nil)
                }
        })
    }
    
    private func updateLoc() {
        if isUpdatingLocation {
            if CLLocationManager.authorizationStatus() == .notDetermined {
                locManager.requestWhenInUseAuthorization()
            }else{
                locManager.startUpdatingLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("ERROR!! locationManager-didFailWithError: \(error)")
        if (error as NSError).code == CLError.locationUnknown.rawValue {
            return
        }

    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        currentLocation = locations.first!

        print("Got It location: \(locations.description)")
        DispatchQueue.main.async { [weak self] in
            self?.getAddressFromLatLon(latitude: "\(self?.currentLocation.coordinate.latitude ?? 0.0 )", longitude: "\(self?.currentLocation.coordinate.longitude ?? 0.0)")
        }
    }
    

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .restricted, .denied:
            print("Denied or Restricted")
            DispatchQueue.main.async { [weak self] in
                self?.getAddressFromLatLon(latitude: "-6.175510", longitude: "106.827164") // monass
            }
        case .authorizedWhenInUse, .authorizedAlways:
            print("Req Auth")
            updateLoc()
        case .notDetermined:
            print("Req Auth")
            locManager.requestWhenInUseAuthorization()
        @unknown default:
            fatalError()
        }
    }
}
