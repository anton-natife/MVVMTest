//
//  AppDelegate.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 29.04.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow()
        
        let module = FirstWireFrame.create()
        let navigation = UINavigationController(rootViewController: module)
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
