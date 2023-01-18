//
//  AppDelegate.swift
//  Demo
//
//  Created by Dzianis Shykunets on 17.01.23.
//

import UIKit
import Alidade
import Moondial

class MyCustomNavigation: UINavigationController {
  
  override var shouldAutorotate: Bool {
    return false
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .portrait
  }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    public var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UI.setBaseWidths([.pad: 768, .phone: 375])
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        
        MoondialSettings.set(shimmerColors: [
            UIColor.magenta.withAlphaComponent(0.04).cgColor,
            UIColor.magenta.withAlphaComponent(0.9).cgColor,
            UIColor.cyan.withAlphaComponent(0.14).cgColor,
            UIColor.magenta.withAlphaComponent(0.9).cgColor,
            UIColor.magenta.withAlphaComponent(0.04).cgColor
        ])
        MoondialSettings.set(animationDurationInMillis: 1.8)
        
        
        let controller = MyCustomNavigation(rootViewController: ViewController())
        window.rootViewController = controller
        window.makeKeyAndVisible()
        self.window = window
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

