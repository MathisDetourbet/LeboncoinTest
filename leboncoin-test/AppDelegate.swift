//
//  AppDelegate.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 12/10/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootCoordinator: NavCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Init and setup window with a navigation controller
        let window = UIWindow()
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        
        startRootCoordinator(with: navigationController)
        
        return true
    }
    
    private func startRootCoordinator(with navigationController: UINavigationController) {
        // Start navigation with the initial view controller
        rootCoordinator = RootCoordinator(navigationController: navigationController)
        rootCoordinator.start()
    }
}

