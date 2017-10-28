//
//  AddUserAccountIneractorWorker.swift
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
  let offset: String?        // paging
  let moreAvailable: Bool?
  let localCount: Int?    // keeps track of the items limit
}

final class AddUserAccountInteractorWorker {
  
  // MARK: Properties
  
  weak var iteractor: AddUserAccountInteractorWorkerInputProtocol?
  var media: InstagramMedia
  
  
  // MARK: Worker Life Cycle
  
  init(media: InstagramMedia) {
    self.media = media
  }
  
  
  //Map and store instagramMedia using Mappable and Realm
  func importFromMedia() throws {
//    guard let items = self.response["items"] as? [[String: Any]] else {
//      throw InsightsWorkerError.invalidResponseKeyNotFound("items")
//    }
//    AppDataStore.importInstagramMedia(instagramMedia: items)
    
    // DB 저장하기,
    
    
    // 저장한 후,
    try! self.prepareWorkerOutput()
  }
  
  fileprivate func prepareWorkerOutput() {
//    let status = self.response["status"] as! String
//    let itemIndex = AppDataStore.getInstagramMediaIndex()
//    let moreAvailable = self.response["more_available"] as! Bool
//    let output = InsightsWorkerOutput(status: status, offset: itemIndex.offset, moreAvailable: moreAvailable, localCount: itemIndex.count)
    
    let output = AddUserAccountInteractorWorkerOutput(
      offset: self.media.items.sorted { $0.createdTime > $1.createdTime }.last?.id,
      moreAvailable: self.media.moreAvailable,
      localCount: self.media.items.count
    )
    self.iteractor?.didFinishImporting(output)
  }
  
}
