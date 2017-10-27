//
//  AddUserAccountSection.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 26..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

enum AddUserAccountViewSection {
  case editAccount([AddUserAccountsViewSectionItem])
}

extension AddUserAccountViewSection {
  
  var items: [AddUserAccountsViewSectionItem] {
    switch self {
    case .editAccount(let items): return items
    }
  }
  
}

enum AddUserAccountsViewSectionItem {
  case editAccount
}
