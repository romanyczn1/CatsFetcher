//
//  AppDelegate.swift
//  targSoft
//
//  Created by Roman Bukh on 7.08.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow()
        coordinator = AppCoordinator(window: window)
        coordinator?.start()
        
        return true
    }

}

