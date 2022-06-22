//
//  AppDelegate.swift
//  CatchTest
//
//  Created by Adonis Dumadapat on 6/22/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.

    let sb = UIStoryboard(name: "LoremList", bundle: nil)

    let vc = sb.instantiateViewController(withIdentifier: "LoremListController") as! LoremListController
    vc.viewModel = LoremListViewModel()

    let nc = UINavigationController(rootViewController: vc)
    window?.rootViewController = nc
    window?.makeKeyAndVisible()

    return true
  }
}
