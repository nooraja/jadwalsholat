//
//  SplashController.swift
//  JadwalSholat
//
//  Created by NOOR on 25/11/19.
//  Copyright © 2019 NOOR. All rights reserved.
//

import UIKit
import CoreLocation

class SplashController: UIViewController {
    
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
//        locManager.startUpdatingLocation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if #available(iOS 9, *) {
            locManager.allowsBackgroundLocationUpdates = false
        }
        locManager.stopUpdatingLocation()
    }
}
