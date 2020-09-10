//
//  AppDelegate.swift
//  NearPublic
//
//  Created by ios2 on 2020/9/8.
//  Copyright © 2020 lg. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		if #available(iOS 13, *) {

		}else{
			window = UIWindow.init()
			window?.frame = UIScreen.main.bounds
			window?.makeKeyAndVisible()
			let vc:RootTabBarController  = RootTabBarController()

			let leftVc:MineViewController = MineViewController()

			let rootVc = CyLeftMenuController.leftController(leftVc, andMainController: vc,andLeftMaxWidth: UIScreen.main.bounds.width * 0.8)
			window?.rootViewController = rootVc
		}
		return true
	}

	// MARK: UISceneSession Lifecycle

	@available(iOS 13.0, *)
	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	@available(iOS 13.0, *)
	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}
}
