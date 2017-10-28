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
  
  static func createModule() -> SettingViewController {
    let view = SettingViewController()
    let wireframe = SettingWireframe()
    let interactor = SettingInteractor(settings: Settings())
    let presenter = SettingPresenter(view: view, wireframe: wireframe, interactor: interactor)
    
    view.presenter = presenter
    wireframe.view = view
    interactor.presenter = presenter
    
    return view
  }
  
  private func showIcon8(by url: URL) {
    let safariViewController = SFSafariViewController(url: url)
    self.show(safariViewController, with: .present(from: self.view), animated: true)
  }
  
  private func showOpenSourceList() {
    let carteViewController = CarteViewController()
    self.show(carteViewController, with: .push)
  }
  
  private func showAlert() {
    
  }
  
  private func showAddUserAccountView() {
    let addUserAccountView = AddUserAccountWireframe.createModule()
    self.show(addUserAccountView, with: .push)
  }
  
}


// MARK: - SettingWireframeProtocol

extension SettingWireframe: SettingWireframeProtocol {
  
  func navigate(to route: Router.Setting) {
    switch route {
    case let .icons8(url: url):
      self.showIcon8(by: url)
    case .openSourceLicenses:
      self.showOpenSourceList()
    case .editAccount:
      self.showAddUserAccountView()
    }
  }
  
}
