//
//  CustomTabBarViewController.swift
//  UIKitIntroductionApp DesignCode IOS15
//
//  Created by Sergey Kovalev on 3/26/22.
//

import UIKit

class CustomTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarSetup()
    }
    
    private func tabBarSetup() {
        tabBar.layer.cornerRadius = 30
        tabBar.layer.cornerCurve = .continuous
        tabBar.layer.masksToBounds = true
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        tabBar.selectionIndicatorImage = UIImage(named: "Selected")
        
        tabBar.tintColor = UIColor(named: "TabBarTint")
        additionalSafeAreaInsets.bottom = 20
    }
}
