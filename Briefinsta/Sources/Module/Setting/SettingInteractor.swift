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
}


final class SettingInteractor {
  
  // MARK: Properties
  
  weak var presenter: SettingInteractorOutputProtocol!
  
  private let settings: Settings
  
  //  var currentSetting: ServiceSetting
  var accountName: String?
  
  init(settings: Settings = Settings()) {
    self.settings = settings
  }
}


// MARK: - InteractorInputProtocol

extension SettingInteractor: SettingInteractorInputProtocol {
  
}
