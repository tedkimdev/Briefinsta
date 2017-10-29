//
//  MainTabBarInteractor.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 28..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

protocol MainTabBarInteractorInputProtocol: class {
  // Presenter -> Interactor
}

// MARK: - Class Implementation

final class MainTabBarInteractor {
  weak var presenter: MainTabBarInteractorOutputProtocol!
  
  init() {
  }
  
}

// MARK: - InteractorInputProtocol

extension MainTabBarInteractor: MainTabBarInteractorInputProtocol {
}
