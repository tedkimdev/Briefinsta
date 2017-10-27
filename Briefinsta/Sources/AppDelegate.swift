//
//  AppDelegate.swift
//  briefinsta
//
//  Created by aney on 2017. 10. 24..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

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
//    let mainViewController = MainWireframe.createModule()
    let settingViewController = SettingWireframe.createModule()
    AppWireframe.shared.setupKeyWindow(window!, viewController: settingViewController)
  }
  
  
  // MARK: Setup UIAppearance
  
  private func setupAppearance() {
    UINavigationBar.appearance().shadowImage = UIImage()
    UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    UINavigationBar.appearance().tintColor = UIColor.red
    UITabBar.appearance().tintColor = UIColor.init(red: 233/255, green: 79/255, blue: 97/255, alpha: 1)
  }

}

