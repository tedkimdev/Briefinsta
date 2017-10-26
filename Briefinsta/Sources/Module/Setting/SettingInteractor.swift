//
//  SettingInteractor.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 25..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

protocol SettingInteractorInputProtocol: class {
  // Presenter -> Interactor
  func validateAccount(with username: String)
}


final class SettingInteractor {
  
  // MARK: Properties
  
  weak var presenter: SettingInteractorOutputProtocol!
  
  private let instagramService: InstagramServiceType
  private let settings: Settings
  
  //  var currentSetting: ServiceSetting
  var accountName: String?
  
  init(instagramService: InstagramServiceType, settings: Settings = Settings()) {
    self.instagramService = instagramService
    self.settings = settings
  }
}


// MARK: - InteractorInputProtocol

extension SettingInteractor: SettingInteractorInputProtocol {
  
  func validateAccount(with username: String) {
    print("Interactor.validateAccount")
    self.instagramService.user(with: username) { result in
      switch result {
      case .success(let media):
        print(media)
        if media.count > 0  {
          self.settings.setUserAccount(value: username)
          // TODO: 로드 하시겠습니까?
          
          // save db
          
        } else {
//          self.stopLoading()
        }
        
      case .error(let error):
        // TODO: error 처리
        print(error)
//        self.stopLoading()
      }
    }
  }
  
  fileprivate func downloadData() {
    guard let name = self.settings.getUserAccount() else { return }
    
    self.performFetchMedia(name, offset: 0)
  }
  
  fileprivate func performFetchMedia(_ username: String?, offset: Int) {
    
  }
  
}
