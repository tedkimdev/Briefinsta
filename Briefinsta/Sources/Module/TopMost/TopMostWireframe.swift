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
}

final class TopMostWireframe: BaseWireframe {
  
  static func createModule(dataService: DataServiceType, settings: Settings) -> TopMostViewController {
    let view = TopMostViewController()
    let wireframe = TopMostWireframe()
    let interactor = TopMostInteractor(dataService: dataService, settings: settings)
    let presenter = TopMostPresenter(view: view, wireframe: wireframe, interactor: interactor)
    
    view.presenter = presenter
    wireframe.view = view
    interactor.presenter = presenter
    
    return view
  }
}

extension TopMostWireframe: TopMostWireframeProtocol {
}
