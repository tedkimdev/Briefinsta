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
  func currentUserAccount()
  func getCurrentMaxMediaCount()
  func changeMaxMediaNumber(_ value: Int)
  func deleteStoredMediaAll()
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
  
    NotificationCenter.default.addObserver(self, selector: #selector(currentUserAccount), name: Notification.Name(rawValue:"analysisCompleted"), object: nil)
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
}


// MARK: - InteractorInputProtocol

extension SettingInteractor: SettingInteractorInputProtocol {
  
  @objc func currentUserAccount() {
    self.presenter.setUsername(self.settings.getUserAccount())
  }
  
  func getCurrentMaxMediaCount() {
    return self.presenter.setmaxMediaNumber(self.settings.getMaxColletingPosts() ?? 1000)
  }
  
  func changeMaxMediaNumber(_ value: Int) {
    self.settings.setMaxColletingPosts(value: value)
    self.presenter.presentUpdatedSettingView()
  }
  
  func deleteStoredMediaAll() {
    self.settings.setUserAccount(value: nil)
    self.dataService.deleteAll { result in
      switch result {
      case .success:
        self.presenter.presentDeletedData(message: "Deleted all data.")
        NotificationCenter.default.post(name: Notification.Name(rawValue:"allDataDeleted"), object: nil)
      
      case .failure(let error):
        self.presenter.presentAlertController(message: error.localizedDescription)
      }
    }
  }
  
}
