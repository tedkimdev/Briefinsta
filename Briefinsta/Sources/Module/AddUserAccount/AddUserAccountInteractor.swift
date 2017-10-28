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
}

protocol AddUserAccountInteractorWorkerInputProtocol: class {
  func didFinishImporting(_ output: AddUserAccountInteractorWorkerOutput?)
}

final class AddUserAccountInteractor {
  
  // MARK: Properties
  
  weak var presenter: AddUserAccountInteractorOutputProtocol!
  
  private let instagramService: InstagramServiceType
  private let settings: Settings
  
  var worker: AddUserAccountInteractorWorker?
  var accountName: String?
  
  init(
    instagramService: InstagramServiceType,
    settings: Settings = Settings()
  ) {
    self.instagramService = instagramService
    self.settings = settings
  }
}


// MARK: - InteractorInputProtocol

extension AddUserAccountInteractor: AddUserAccountInteractorInputProtocol {
  
  func validateAccount(with username: String) {
    print("Interactor.validateAccount")
    self.instagramService.user(with: username) { result in
      switch result {
      case .success(let media):
        print(media)
        if media.count > 0  {
          self.settings.setUserAccount(value: username)
          self.accountName = username
          self.downloadMedia()
        } else {
          self.stopLoading(with: "There is no media")
        }
        
      case .failure(let error):
        self.stopLoading(with: error.localizedDescription)
        print(error)
      }
    }
  }
  
  fileprivate func stopLoading(with message: String){
    self.presenter.presentAlertController(message: message)
  }
  
}


// MARK: - Downloading data

extension AddUserAccountInteractor {
  
  fileprivate func downloadMedia() {
    guard let name = self.settings.getUserAccount() else { return }
    
    self.performFetchMedia(name, offset: nil)
  }
  
  fileprivate func performFetchMedia(_ username: String, offset: String?) {
    self.instagramService.meida(with: username, offset: offset) { result in
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
  
  fileprivate func initAddUserAccountInteractorWorker(with media: InstagramMedia) {
    self.worker = AddUserAccountInteractorWorker(media: media)
    self.worker?.iteractor = self
    DispatchQueue.global(qos: .background).async {
      try? self.worker?.importFromMedia()
    }
  }
  
}


// MARK: - Error handling

extension AddUserAccountInteractor {
  
  fileprivate func loadFetchMediaFailureAlert(error:Error) {
    self.presenter.presentAlertController(message: error.localizedDescription)
  }
  
  fileprivate func loadStoredMedia() {
    print("Interactor.loadStoredMedia")
    // TODO: loadStoredMedia
//    let bestEngagement = AppDataStore.getBestEngagement(with: 25)
//    let lastWeeksPosted = AppDataStore.getLastWeeksPosted(weeks: 12)
//    let topMostCommented = AppDataStore.getMostLiked(with: 25)
//    let bestEngagementDictionary: [String: Any] = ["sectionTitle":  AppConfiguration.TableViewSections.zero, "items": bestEngagement]
//    let mostCommentedDictionary: [String: Any] = ["sectionTitle": AppConfiguration.TableViewSections.one, "items": topMostCommented]
//    let lastWeeksPostedDictionary: [String: Any] = ["sectionTitle":  AppConfiguration.TableViewSections.two, "items": lastWeeksPosted]
//    self.presenter?.presentLoadedSections(with: [bestEngagementDictionary,mostCommentedDictionary,lastWeeksPostedDictionary])
  }
}


// MARK: - AddUserAccountInteractorWorkerInputProtocol

extension AddUserAccountInteractor: AddUserAccountInteractorWorkerInputProtocol {
  
  func didFinishImporting(_ output: AddUserAccountInteractorWorkerOutput?) {
    
    if let moreAvailable = output?.moreAvailable,
      let localCount = output?.localCount,
      moreAvailable && localCount < 100 { //몇개까지로 제한?? 1000? continue
      self.performFetchMedia(self.accountName!, offset: output?.offset)
    } else {  // end
      DispatchQueue.main.async {
        self.loadStoredMedia()
      }
    }
  }
  
}
