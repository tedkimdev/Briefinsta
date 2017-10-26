//
//  SettingWireframe.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 25..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation
import SafariServices

import Carte

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
  
  private func showIcon8(by url: URL, from: SettingViewProtocol) {
    let safariViewController = SFSafariViewController(url: url)
    self.show(safariViewController,
              with: .present(from: from as! UIViewController),
              animated: true)
  }
  
  private func showOpenSourceList() {
    let carteViewController = CarteViewController()
    self.show(carteViewController, with: .push)
  }
  
  private func showAlert() {
    
  }
  
}


// MARK: - MainWireframeProtocol

extension SettingWireframe: SettingWireframeProtocol {
  
  func navigate(to route: Router.Setting) {
    switch route {
    case let .icons8(url: url, from: viewController):
      self.showIcon8(by: url, from: viewController)
    case .openSourceLicenses:
      self.showOpenSourceList()
    case .editAccount:
      self.showAlert()
    }
  }
  
}
