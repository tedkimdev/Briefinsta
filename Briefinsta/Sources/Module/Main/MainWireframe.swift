//
//  MainWireframe.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 25..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

protocol MainWireframeProtocol: class {
  // Presenter -> Wireframe
  func navigate(to route: Router.Main)
}

final class MainWireframe: BaseWireframe {
  
  static func createModule() -> MainViewController {
    let view = MainViewController()
    let wireframe = MainWireframe()
//    let interactor = MainInteractor(service: service, serviceSetting: serviceSetting)
//    let presenter = MainPresenter(view: view, wireframe: wireframe, interactor: interactor)
    
//    view.presenter = presenter
    wireframe.view = view
//    interactor.presenter = presenter
    return view
  }
  
  private func showOtherView() {
//    let oterViewController = OtherViewController()
//    self.show(otherView, with: .push)
  }
  
}


// MARK: - MainWireframeProtocol

extension MainWireframe: MainWireframeProtocol {
  func navigate(to route: Router.Main) {
    switch route {
    case .editAccount:
      print("go other page")
    }
  }
}
