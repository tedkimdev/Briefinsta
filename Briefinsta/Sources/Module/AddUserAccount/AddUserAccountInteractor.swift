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
  
  fileprivate func downloadMedia() {
    guard let name = self.settings.getUserAccount() else { return }
    self.performFetchMedia(name, offset: nil)
  }
  
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
    print("Interactor.loadStoredMedia")
    self.presenter.presentAnalysisCompleted()
    // TODO: loadStoredMedia
    // pass the media to other page by using wireframe
    
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
    print("AddUserAccountInteractor.didFinishImporting")
    if let moreAvailable = output?.moreAvailable,
      let localCount = output?.localCount,
      moreAvailable && localCount < 100 { //몇개까지로 제한?? 1000? continue
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
