//
//  TopMostWireframe.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 28..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

protocol TopMostWireframeProtocol: class {
  // Presenter -> Wireframe
//  func navigate(to route: Router.Setting)
}

final class TopMostWireframe: BaseWireframe {
  
  static func createModule(dataService: DataServiceType) -> TopMostViewController {
    let view = TopMostViewController()
    let wireframe = TopMostWireframe()
    let interactor = TopMostInteractor(dataService: dataService)
    let presenter = TopMostPresenter(view: view, wireframe: wireframe, interactor: interactor)
    
    view.presenter = presenter
    wireframe.view = view
    interactor.presenter = presenter
    
    return view
  }
}

extension TopMostWireframe: TopMostWireframeProtocol {
  
}
