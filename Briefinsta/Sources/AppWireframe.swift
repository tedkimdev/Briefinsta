//
//  AppWireframe.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 24..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

class AppWireframe: BaseWireframe {
  static let shared = AppWireframe()
  private override init() { }
  
  weak var window: UIWindow!
  
  func setupKeyWindow(_ window: UIWindow, viewController: UIViewController) {
    self.window = window
    let navigationController = UINavigationController(rootViewController: viewController)
    show(navigationController, with: .root(window: window))
    window.makeKeyAndVisible()
  }
}
