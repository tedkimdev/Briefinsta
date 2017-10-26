//
//  MainInteractor.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 25..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

protocol MainInteractorInputProtocol: class {
  // Presenter -> Interactor
  
}

// MARK: - Class Implementation

final class MainInteractor {
  weak var presenter: MainInteractorOutputProtocol!
  
//  var currentSetting: ServiceSetting
//  private let gitHubService: GitHubServiceType
  
//  init(service: GitHubServiceType, serviceSetting: ServiceSetting) {
//    gitHubService = service
//    currentSetting = serviceSetting
//  }
  init() {
    
  }
}

// MARK: - InteractorInputProtocol

extension MainInteractor: MainInteractorInputProtocol {
  
}
