//
//  SplashController+CLLocationManager.swift
//  JadwalSholat
//
//  Created by NOOR on 23/11/19.
//  Copyright © 2019 NOOR. All rights reserved.
//

import CoreLocation

extension SplashController: CLLocationManagerDelegate {
    
    func stopLocationManager() {
        locManager.stopUpdatingLocation()
    }
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        
        let lon: Double = Double("\(pdblLongitude)")!
        
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
                    
                    self?.present(
                        HomeController(viewModel:
                            JadwalViewModel(networkModel: JadwalNetworkModel(), name: province), province: province), animated: false,completion: nil)
                    
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

        stopLocationManager()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        currentLocation = locations.first!
        
        print("Got It location: \(locations.description)")
        DispatchQueue.main.async { [weak self] in
            self?.getAddressFromLatLon(pdblLatitude: "\(self?.currentLocation.coordinate.latitude ?? 0.0 )", withLongitude: "\(self?.currentLocation.coordinate.longitude ?? 0.0)")
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status)
        if status == .notDetermined {
            print("Req Auth")
            locManager.requestWhenInUseAuthorization()
        } else if status == .denied || status == .restricted {
            print("Denied or Restricted")
        } else {
            updateLoc()
            locManager.startUpdatingLocation()
        }
    }
}
