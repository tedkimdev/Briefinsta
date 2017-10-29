//
//  Router.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 24..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

enum Router {
  enum Main {
    case editAccount
  }
  
  enum Setting {
    case icons8(url: URL)
    case openSourceLicenses
    case editAccount
    case alert(title: String, message: String)
  }
  
  enum AddUserAccount {
    case alert(title: String, message: String)
    case completed(title: String, message: String)
  }
}
