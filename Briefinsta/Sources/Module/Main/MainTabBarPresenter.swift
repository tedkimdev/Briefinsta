//
//  MainTabBarPresenter.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 28..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

protocol MainTabBarPresenterProtocol: class, BasePresenterProtocol {
}

protocol MainTabBarInteractorOutputProtocol: class {
  // Interactor -> Presenter
}

final class MainTabBarPresenter {
  
  // MARK: Properties
  
  weak var view: MainTabBarViewProtocol!
  private let wireframe: MainTabBarWireframeProtocol
  private let interactor: MainTabBarInteractorInputProtocol
  
  
  // MARK: Initializing
  
  init(view: MainTabBarViewProtocol,
       wireframe: MainTabBarWireframeProtocol,
       interactor: MainTabBarInteractorInputProtocol) {
    self.view = view
    self.wireframe = wireframe
    self.interactor = interactor
  }
  
}


// MARK: - MainTabBarPresenterProtocol

extension MainTabBarPresenter: MainTabBarPresenterProtocol {
}


// MARK: - MainInteractorOutputProtocol

extension MainTabBarPresenter: MainTabBarInteractorOutputProtocol {
}

