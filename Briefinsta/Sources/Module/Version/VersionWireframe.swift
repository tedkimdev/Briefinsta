//
//  VersionWireframe.swift
//  Briefinsta
//
//  Created by aney on 2017. 11. 1..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

protocol VersionWireframeProtocol: class {
  // Presenter -> Wireframe
}


final class VersionWireframe: BaseWireframe {
  
  static func createModule() -> VersionViewController {
    let appStoreService = AppStoreService()
    
    let view = VersionViewController()
    let wireframe = VersionWireframe()
    let interactor = VersionInteractor(appStoreService: appStoreService)
    
    let presenter = VersionPresenter(view: view, wireframe: wireframe, interactor: interactor)
    
    view.presenter = presenter
    wireframe.view = view
    interactor.presenter = presenter
    
    return view
  }
  
}


// MARK: - VersionWireframeProtocol

extension VersionWireframe: VersionWireframeProtocol {
}
