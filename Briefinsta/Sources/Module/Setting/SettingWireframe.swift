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
  
  private var dataService: DataServiceType
  private var instagramService: InstagramServiceType
  private var settings: Settings
  
  static func createModule(
    instagramService: InstagramServiceType,
    dataService: DataServiceType,
    settings: Settings
  ) -> SettingViewController {
    let view = SettingViewController()
    let wireframe = SettingWireframe(dataService: dataService, instagramService: instagramService, settings: settings)
    let interactor = SettingInteractor(dataService: dataService, settings: settings)
    let presenter = SettingPresenter(view: view, wireframe: wireframe, interactor: interactor)
    
    view.presenter = presenter
    wireframe.view = view
    interactor.presenter = presenter
    
    return view
  }
  
  
  // MARK: Initializing
  
  init(dataService: DataServiceType, instagramService: InstagramServiceType, settings: Settings) {
    self.dataService = dataService
    self.instagramService = instagramService
    self.settings = settings
  }
  
  private func showIcon8(by url: URL) {
    let safariViewController = SFSafariViewController(url: url)
    self.show(safariViewController, with: .present(from: self.view), animated: true)
  }
  
  private func showOpenSourceList() {
    let carteViewController = CarteViewController()
    self.show(carteViewController, with: .push)
  }
  
  private func showAddUserAccountView() {
    let addUserAccountView = AddUserAccountWireframe.createModule(
      instagramService: self.instagramService,
      dataService: self.dataService,
      settings: self.settings
    )
    self.show(addUserAccountView, with: .push)
  }
  
  private func showAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(action)
    
    self.show(alertController, with: .present(from: self.view), animated: true)
  }
  
  private func showVersionView() {
    let versionView = VersionWireframe.createModule()
    self.show(versionView, with: .push)
  }
}


// MARK: - SettingWireframeProtocol

extension SettingWireframe: SettingWireframeProtocol {
  
  func navigate(to route: Router.Setting) {
    switch route {
    case .version:
      self.showVersionView()
    case let .icons8(url: url):
      self.showIcon8(by: url)
    case .openSourceLicenses:
      self.showOpenSourceList()
    case .editAccount:
      self.showAddUserAccountView()
    case .alert(title: let title, message: let message):
      self.showAlert(title: title, message: message)
    }
  }
  
}


// MARK: - MainTabBarItemsWireframeProtocol

extension SettingWireframe: MainTabBarViewProtocol {
  
}
