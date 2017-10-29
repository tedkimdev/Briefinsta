//
//  SettingViewSection.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 26..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

enum SettingViewSection {
  case about([SettingsViewSectionItem])
  case account([SettingsViewSectionItem])
  case maxPosts([SettingsViewSectionItem])
  case delete([SettingsViewSectionItem])
}

extension SettingViewSection {
  
  var items: [SettingsViewSectionItem] {
    switch self {
    case .about(let items): return items
    case .account(let items): return items
    case .maxPosts(let items): return items
    case .delete(let items): return items
    }
  }
  
  var headerName: String {
    switch self {
    case .about:
      return "Information"
    case .account:
      return "User Account"
    case .maxPosts:
      return "Total Collecting Count"
    case .delete:
      return ""
    }
  }
  
}

enum SettingsViewSectionItem {
  case version(String, String)
  case github(String)
  case icons(String)
  case openSource(String)
  case account
  case maxPosts(Int)
  case delete(String)
}
