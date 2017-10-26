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
  case logout([SettingsViewSectionItem])
}

extension SettingViewSection {
  
  var items: [SettingsViewSectionItem] {
    switch self {
    case .about(let items): return items
    case .account(let items): return items
    case .logout(let items): return items
    }
  }
  
  var headerName: String {
    switch self {
    case .about(_):
      return "Information"
    case .account(_):
      return "User Account"
    case .logout(_):
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
  case logout(String)
}
