//
//  TopMostViewSection.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 28..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

struct TopMostViewSection {
  let title: String
  let items: [InstagramMediaViewModel]
}


struct InstagramMediaViewModel {
  let likes: String
  let comments: String
  let imageURL: String
  
  init(_ medium: Medium) {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    
    self.likes = formatter.string(from: NSNumber(integerLiteral: medium.likesCount))!
    self.comments = formatter.string(from: NSNumber(integerLiteral: medium.commentsCount))!
    self.imageURL = medium.imageURL
  }
  
  init(likes: String, comments: String, imageURL: String) {
    self.likes = likes
    self.comments = comments
    self.imageURL = imageURL
  }
  
  static func sample() -> InstagramMediaViewModel {
    return InstagramMediaViewModel(likes: "999", comments: "999", imageURL: "")
  }
  
}

