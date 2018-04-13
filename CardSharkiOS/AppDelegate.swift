//
//  AppDelegate.swift
//  CardSharkiOS
//
//  Created by Kenny Dang on 4/11/18.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = .customDarkBlue
        
        let initialViewController = InitialViewController()
        let navigationViewController = UINavigationController(rootViewController: initialViewController)
        
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
     
        return true
    }
}

