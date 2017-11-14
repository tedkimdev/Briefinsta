//
//  VersionInteractor.swift
//  Briefinsta
//
//  Created by aney on 2017. 11. 1..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

protocol VersionInteractorInputProtocol: class {
  // Presenter -> Interactor
  func lastestVersion()
}


final class VersionInteractor {
  
  // MARK: Properties
  
  weak var presenter: VersionInteractorOutputProtocol!
  
  private let appStoreService: AppStoreServiceType
  
  
  // MARK: Initializing
  
  init(appStoreService: AppStoreServiceType) {
    self.appStoreService = appStoreService
  }
  
}


// MARK: - InteractorInputProtocol

extension VersionInteractor: VersionInteractorInputProtocol {
  
  func lastestVersion() {
    self.appStoreService.latestVersion { result in
      switch result {
      case .success(let value):
        self.presenter.presentLastestVersion(version: value)
        
      case .failure(let error):
        print(error)
      }
    }
  }
  
}
