//
//  AddUserAccountInteractor.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 26..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

protocol AddUserAccountInteractorInputProtocol: class {
  // Presenter -> Interactor
  func validateAccount(with username: String)
  func deleteAllData()
}


protocol AddUserAccountInteractorWorkerInputProtocol: class {
  func didFinishImporting(_ output: AddUserAccountInteractorWorkerOutput?)
  func errorOccured(_ error: Error)
}


final class AddUserAccountInteractor {
  
  // MARK: Properties
  
  weak var presenter: AddUserAccountInteractorOutputProtocol!
  
  private let instagramService: InstagramServiceType
  private let dataService: DataServiceType
  private let settings: Settings
  
  var worker: AddUserAccountInteractorWorker?
  var username: String?
  private var localCountLimit = 0
  private var collectedCount = 0
  
  
  // MARK: Initializing
  
  init(
    instagramService: InstagramServiceType,
    dataService: DataServiceType,
    settings: Settings = Settings()
  ) {
    self.instagramService = instagramService
    self.dataService = dataService
    self.settings = settings
  }
  
  fileprivate func stopLoading(with message: String){
    self.presenter.presentAlertController(message: message)
  }
  
}


// MARK: - InteractorInputProtocol

extension AddUserAccountInteractor: AddUserAccountInteractorInputProtocol {
  
  func validateAccount(with username: String) {
    self.instagramService.user(with: username) { result in
      switch result {
      case .success(let media):
        print(media)
        if media.count > 0  {
          self.settings.setUserAccount(value: username)
          self.localCountLimit = self.settings.getMaxColletingPosts() ?? 1000
          self.username = username
          self.downloadMedia()
        } else {
          self.stopLoading(with: "\(username) has no media")
        }
        
      case .failure(let error):
        self.stopLoading(with: error.localizedDescription)
      }
    }
  }
  
  func deleteAllData() {
    self.dataService.deleteAll { result in
      switch result {
      case .success:
        break
      case .failure(let error):
        self.stopLoading(with: error.localizedDescription)
      }
    }
  }
  
}


// MARK: - Downloading data

extension AddUserAccountInteractor {
  
  /// start download #1
  fileprivate func downloadMedia() {
    guard let name = self.settings.getUserAccount() else { return }
    self.collectedCount = 0
    self.performFetchMedia(name, offset: nil)
  }
  
  /// continue download #2
  fileprivate func performFetchMedia(_ username: String, offset: String?) {
    self.instagramService.media(with: username, offset: offset) { result in
      switch result {
      case .success(let media):
        if media.items.count > 0 {
          self.initAddUserAccountInteractorWorker(with: media)
        } else {
          self.loadStoredMedia()
        }
        
      case .failure(let error):
        self.loadFetchMediaFailureAlert(error: error)
      }
    }
  }
  
  /// Init worker and start work
  fileprivate func initAddUserAccountInteractorWorker(with media: InstagramMedia) {
    self.worker = AddUserAccountInteractorWorker(media: media, dataService: self.dataService)
    self.worker?.iteractor = self
    DispatchQueue.global(qos: .background).async {
      self.worker?.importFromMedia()
    }
  }
  
}


// MARK: - Error handling

extension AddUserAccountInteractor {
  
  fileprivate func loadFetchMediaFailureAlert(error:Error) {
    self.presenter.presentAlertController(message: error.localizedDescription)
  }
  
  fileprivate func loadStoredMedia() {
    self.presenter.presentAnalysisCompleted()
    NotificationCenter.default.post(name: Notification.Name(rawValue:"analysisCompleted"), object: nil)
  }
}


// MARK: - AddUserAccountInteractorWorkerInputProtocol

extension AddUserAccountInteractor: AddUserAccountInteractorWorkerInputProtocol {
  
  /// continue downlaod #3 (repeat #2, #3)
  func didFinishImporting(_ output: AddUserAccountInteractorWorkerOutput?) {
    if let moreAvailable = output?.moreAvailable,
      let localCount = output?.localCount,
      moreAvailable && (self.collectedCount + localCount) < self.localCountLimit {
      self.collectedCount += localCount
      self.performFetchMedia(self.username!, offset: output?.offset)
    } else {  // end
      DispatchQueue.main.async {
        self.loadStoredMedia()
      }
    }
  }
  
  func errorOccured(_ error: Error) {
    
  }
  
}
