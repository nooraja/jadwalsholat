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
    
    private lazy var titleLabel: UITextView = {
        let label = UITextView(frame: .zero)
        label.font = UIFont(name: "Monaco", size: 100)
        label.textAlignment = .center
        label.textColor = .telegramBlue
        label.textAlignment = .center
        label.backgroundColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: view.frame.height)
        
        let mutableAttributedString = NSMutableAttributedString()
        
        let boldAttribute = [
            NSAttributedString.Key.font: UIFont(name: "Mishafi", size: 100)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]

        let regularAttribute = [
            NSAttributedString.Key.font: UIFont(name: "Mishafi", size: 40)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]

        let boldAttributedString = NSAttributedString(string: "JS", attributes: boldAttribute)
        let regularAttributedString = NSAttributedString(string: "\nJam sholat", attributes: regularAttribute)
        mutableAttributedString.append(boldAttributedString)
        mutableAttributedString.append(regularAttributedString)
        
        titleLabel.attributedText = mutableAttributedString
        
        
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        locManager.delegate = self
        locManager.requestWhenInUseAuthorization()
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 9, *) {
            locManager.allowsBackgroundLocationUpdates = true
        }
        locManager.startUpdatingLocation()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { [weak self] in

            guard let province = self?.province else {
                return
            }
            
            self?.present(
                HomeController(viewModel:
                    JadwalViewModel(networkModel: JadwalNetworkModel(), name: province)), animated: false,completion: nil)
        }
    }
}
