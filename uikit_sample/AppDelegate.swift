////
////  AppDelegate.swift
////  uikit_sample
////
////  Created by TshujiTakayuki on 2025/04/13.
////
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?  // iOS 12ではこれが必要！

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let firstVC = ViewController()
        let navigationC = UINavigationController(rootViewController: firstVC)
        window?.rootViewController = navigationC
        window?.makeKeyAndVisible()

        return true
    }
}
