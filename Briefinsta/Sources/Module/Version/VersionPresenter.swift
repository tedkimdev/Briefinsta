//
//  VersionPresenter.swift
//  Briefinsta
//
//  Created by aney on 2017. 11. 1..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

protocol VersionPresenterProtocol: class, BasePresenterProtocol {
  // View -> Presenter
}


protocol VersionInteractorOutputProtocol: class {
  // Interactor -> Presenter
  func presentCurrentVersion(version: String)
}


final class VersionPresenter {
  
  // MARK: Properties
  
  weak var view: VersionViewProtocol!
  private let wireframe: VersionWireframeProtocol
  private let interactor: VersionInteractorInputProtocol

  
  // MARK: Initializing
  
  init(view: VersionViewProtocol,
       wireframe: VersionWireframeProtocol,
       interactor: VersionInteractorInputProtocol) {
    self.view = view
    self.wireframe = wireframe
    self.interactor = interactor
  }
  
  func onViewDidLoad() {
    self.interactor.lastestVersion()
  }
  
}


// MARK: - VersionPresenterProtocol

extension VersionPresenter: VersionPresenterProtocol {
}


// MARK: - VersionInteractorOutputProtocol

extension VersionPresenter: VersionInteractorOutputProtocol {
  
  func presentCurrentVersion(version: String) {
    self.view.displayCurrentVersion(version)
  }
  
}
