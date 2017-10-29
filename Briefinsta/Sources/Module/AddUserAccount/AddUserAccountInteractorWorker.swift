//
//  AddUserAccountInteractorWorker.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 26..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

enum AddUserAccountInteractorWorkerError: Error {
  case invalidInstagramMedia(String)
}


struct AddUserAccountInteractorWorkerOutput {
  let offset: String?       // paging
  let moreAvailable: Bool?
  let localCount: Int?      // keeps track of the items limit
}

final class AddUserAccountInteractorWorker {
  
  // MARK: Properties
  
  weak var iteractor: AddUserAccountInteractorWorkerInputProtocol?
  private let dataService: DataServiceType
  var media: InstagramMedia
  
  
  // MARK: Worker Life Cycle
  
  init(media: InstagramMedia, dataService: DataServiceType) {
    self.media = media
    self.dataService = dataService
  }
  
  /// Interactor call this function to start work
  func importFromMedia() {
    self.dataService.insertPosts(instagramMedia: self.media.items) { result in
      switch result {
      case .success:
        self.prepareWorkerOutput()
      case .failure(let error):
        self.iteractor?.errorOccured(error)
      }
    }
  }
  
  fileprivate func prepareWorkerOutput() {
    let lastPostID = self.media.items.sorted { $0.createdTime > $1.createdTime }.last?.id
    let output = AddUserAccountInteractorWorkerOutput(
      offset: lastPostID,
      moreAvailable: self.media.moreAvailable,
      localCount: self.media.items.count
    )
    self.iteractor?.didFinishImporting(output)
  }
  
}
