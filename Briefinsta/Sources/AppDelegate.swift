//
//  AppDelegate.swift
//  briefinsta
//
//  Created by aney on 2017. 10. 24..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

import Kingfisher
import ManualLayout
import SnapKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    self.setupAppearance()
    self.setupAppWireframe()
    
    return true
  }
  
  private func setupAppWireframe() {
    window = UIWindow(frame: UIScreen.main.bounds)
    
    let dataService = DataService()
    let instagramService = InstagramService()
    let settings = Settings()
    
    let topMostViewController = TopMostWireframe.createModule(dataService: dataService, settings: settings)
    let settingViewController = SettingWireframe.createModule(instagramService: instagramService, dataService: dataService, settings: settings)
    
    let mainTabBarController = MainTabBarWireframe.createModule(
      viewControllers: [
        topMostViewController,
        settingViewController,
      ].map { viewController -> UINavigationController in
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
      }
    )
    AppWireframe.shared.setupKeyWindow(window!, viewController: mainTabBarController)
  }
  
  
  // MARK: Setup UIAppearance
  
  private func setupAppearance() {
    UINavigationBar.appearance().shadowImage = UIImage()
//    UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    UINavigationBar.appearance().backgroundColor = .white
    UINavigationBar.appearance().tintColor = UIColor.red
    UITabBar.appearance().tintColor = .green//UIColor.init(red: 233/255, green: 79/255, blue: 97/255, alpha: 1)
  }

}

