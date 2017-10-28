//
//  TopMostViewSection.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 28..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

enum TopMostViewSection {
  case topMost([TopMostViewSectionItem])
}

extension TopMostViewSection {
  var items: [TopMostViewSectionItem] {
    switch self {
    case .topMost(let items): return items
    }
  }
}

enum TopMostViewSectionItem {
  case topMost
  case likesCount
}

struct InstagramMediaView {
  let likes: String
  let comments: String
  let imageURL: String
}
