//
//  Wireframe.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 24..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

class BaseWireframe {
  weak var view: UIViewController!
  
  func show(_ viewController: UIViewController, with type: TransitionType, animated: Bool = true) {
    switch type {
    case .push:
      guard let navigationController = view.navigationController else {
        fatalError("Can't push without a navigation controller")
      }
      navigationController.pushViewController(viewController, animated: animated)
    case .present(let sender):
      sender.present(viewController, animated: animated)
    case .root(let window):
      window.rootViewController = viewController
    }
  }
  
  func pop(animated: Bool) {
    if let navigationController = view.navigationController {
      guard navigationController.popViewController(animated: animated) != nil else {
        if let presentingView = view.presentingViewController {
          return presentingView.dismiss(animated: animated)
        } else {
          fatalError("Can't navigate back from \(view)")
        }
      }
    } else if let presentingView = view.presentingViewController {
      presentingView.dismiss(animated: animated)
    } else {
      fatalError("Neither modal nor navigation! Can't navigate back from \(view)")
    }
  }
  
}
