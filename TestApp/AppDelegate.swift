//
//  AppDelegate.swift
//  TestApp
//
//  Created by Melanie Kofman on 26.08.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let services = Services()
        let viewController = RegViewController(service: services)
        let navigationControllet = UINavigationController(rootViewController: viewController)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationControllet
        self.window?.makeKeyAndVisible()
        return true
    }
}
