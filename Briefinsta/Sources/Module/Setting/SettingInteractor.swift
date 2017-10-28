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
  
  private let dataService: DataServiceType
  private let settings: Settings
  
  var accountName: String?
  
  
  // MARK: Initializing
  
  init(dataService: DataServiceType, settings: Settings = Settings()) {
    self.dataService = dataService
    self.settings = settings
  }
}


// MARK: - InteractorInputProtocol

extension SettingInteractor: SettingInteractorInputProtocol {
  
}
