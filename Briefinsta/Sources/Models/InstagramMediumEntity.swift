//
//  InstagramMediumEntity.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 27..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

import RealmSwift

class InstagramMediumEntity: Object {
  
  @objc dynamic var id: String = ""
  @objc dynamic var code: String = ""
  @objc dynamic var username: String = ""
  @objc dynamic var imageURL: String = ""
  @objc dynamic var likesCount: Int = 0
  @objc dynamic var commentsCount: Int = 0
  @objc dynamic var engagementCount: Int = 0
  @objc dynamic var createdTime: Date = Date()
  @objc dynamic var weekday = 0
  @objc dynamic var type: String = ""

  
  // MARK: - Meta

  override static func primaryKey() -> String? {
    return "id"
  }

  override class func indexedProperties() -> [String] {
    return ["createdTime"]
  }

  
  // MARK: - Initializing
  
  convenience init(from: InstagramMedium) {
    self.init()
    self.id = from.id
    self.code = from.code
    self.username = from.username
    self.imageURL = from.imageURL
    self.likesCount = from.likesCount
    self.commentsCount = from.commentsCount
    self.engagementCount = from.engagementCount
    self.createdTime = from.createdTime
    self.weekday = Calendar.current.component(.weekday, from: createdTime)
    self.type = from.type
  }
  
}
