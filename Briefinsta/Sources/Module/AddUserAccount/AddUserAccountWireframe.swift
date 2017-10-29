//
//  AddUserAccountWireframe.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 26..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

protocol AddUserAccountWireframeProtocol: class {
  // Presenter -> Wireframe
  func navigate(to route: Router.AddUserAccount)
}


final class AddUserAccountWireframe: BaseWireframe {
  
  static func createModule(
    instagramService: InstagramServiceType,
    dataService: DataServiceType,
    settings: Settings
  ) -> AddUserAccountViewController {
    let view = AddUserAccountViewController()
    let wireframe = AddUserAccountWireframe()
    let interactor = AddUserAccountInteractor(
      instagramService: instagramService,
      dataService: dataService,
      settings: settings
    )
    let presenter = AddUserAccountPresenter(view: view, wireframe: wireframe, interactor: interactor)
    
    view.presenter = presenter
    wireframe.view = view
    interactor.presenter = presenter
    
    return view
  }
  
  fileprivate func showAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(action)
    
    self.show(alertController, with: .present(from: self.view), animated: true)
  }
  
}


// MARK: - AddUserAccountWireframeProtocol

extension AddUserAccountWireframe: AddUserAccountWireframeProtocol {
  
  func navigate(to route: Router.AddUserAccount) {
    switch route {
    case let .alert(title: title, message: message):
      self.showAlert(title: title, message: message)
    case .completed(let title, let message):
      self.showAlert(title: title, message: message)
    }
  }
  
}
