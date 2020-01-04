//
//  MainTabController.swift
//  JadwalSholat
//
//  Created by NOOR on 04/01/20.
//  Copyright © 2020 NOOR. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let viewController = JadwalController(viewModel: JadwalViewModel(networkModel: JadwalNetworkModel()))
        viewController.modalPresentationStyle = .fullScreen
        viewControllers = [
            generateViewController(rootController: viewController, title: "Home", image: #imageLiteral(resourceName: "ic_home")),
            generateViewController(rootController: UIViewController(), title: "Mesjid", image: #imageLiteral(resourceName: "ic_location"))
        ]
    }
    
    fileprivate func generateViewController(rootController: UIViewController, title: String, image: UIImage) -> UIViewController {
        
        let navigationController = UINavigationController(rootViewController: rootController)

        navigationController.tabBarItem.image = image
        
        return navigationController
    }

}
