//
//  SettingWireframe.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 25..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

protocol SettingWireframeProtocol: class {
  // Presenter -> Wireframe
  func navigate(to route: Router.Setting)
}

final class SettingWireframe: BaseWireframe {
  
  static func createModule(instagramService: InstagramServiceType) -> SettingViewController {
    let view = SettingViewController()
    let wireframe = SettingWireframe()
    let interactor = SettingInteractor(instagramService: instagramService, settings: Settings())
    let presenter = SettingPresenter(view: view, wireframe: wireframe, interactor: interactor)
    
    view.presenter = presenter
    wireframe.view = view
    interactor.presenter = presenter
    
    return view
  }
  
  private func showOtherView() {
    //    let oterViewController = OtherViewController()
    //    self.show(otherView, with: .push)
  }
  
}


// MARK: - MainWireframeProtocol

extension SettingWireframe: SettingWireframeProtocol {
  func navigate(to route: Router.Setting) {
    switch route {
    case .editAccount:
      print("go other page")
    }
  }
}
