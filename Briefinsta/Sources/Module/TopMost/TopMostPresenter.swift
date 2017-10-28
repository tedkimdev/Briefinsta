//
//  TopMostPresenter.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 28..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

protocol TopMostPresenterProtocol: class, BasePresenterProtocol {
  // View -> Presenter
}


protocol TopMostInteractorOutputProtocol: class {
  // Interactor -> Presenter
  func presentEmptySection() // no account
  func presentLoadedSection()
  func presentAlertController(with message: String)
}


final class TopMostPresenter {
  
  // MARK: Properties
  
  weak var view: TopMostViewProtocol!
  private let wireframe: TopMostWireframeProtocol
  private let interactor: TopMostInteractorInputProtocol
  
  private var sections: [TopMostViewSection]?
  
  
  // MARK: Initializing
  
  init(view: TopMostViewProtocol,
       wireframe: TopMostWireframeProtocol,
       interactor: TopMostInteractorInputProtocol) {
    self.view = view
    self.wireframe = wireframe
    self.interactor = interactor
  }

}


// MARK: - TopMostPresenterProtocol

extension TopMostPresenter: TopMostPresenterProtocol {
}


// MARK: - TopMostInteractorOutputProtocol

extension TopMostPresenter: TopMostInteractorOutputProtocol {
  
  func presentEmptySection() {
    print("presentEmptySection")
  }
  
  func presentLoadedSection() {
    print("presentLoadedSection")
  }
  
  func presentAlertController(with message: String) {
    print("presentAlertController")
  }
  
}
