//
//  AppDelegate.swift
//  JadwalSholat
//
//  Created by NOOR on 23/11/19.
//  Copyright © 2019 NOOR. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
    
        if let window = window {
            window.rootViewController = SplashController()
            
            window.makeKeyAndVisible()
            UINavigationBar.appearance().tintColor = .telegramWhite
            UINavigationBar.appearance().barTintColor = .telegramBlue
            UINavigationBar.appearance().titleTextAttributes =
                [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)]
        }

        return true
    }
    
}
