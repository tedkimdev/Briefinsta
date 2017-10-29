//
//  MainTabBarWireframe.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 28..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation
import UIKit

protocol MainTabBarWireframeProtocol: class {
  // Presenter -> Wireframe
}


final class MainTabBarWireframe: BaseWireframe {
  
  static func createModule(viewControllers: [UIViewController]) -> MainTabBarViewController {
    let view = MainTabBarViewController()
    view.viewControllers = viewControllers
    return view
  }
  
}


// MARK: - MainWireframeProtocol

extension MainTabBarWireframe: MainTabBarWireframeProtocol {
}

