//
//  Settings.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 25..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

class Settings {
  
  var defaults: UserDefaults!
  
  init() {
    self.defaults = UserDefaults.standard
  }
  
  func setUserAccount(value: String) {
    self.defaults.set(value, forKey: "UserAccount")
    self.defaults.synchronize()
  }
  
  func getUserAccount() -> String? {
    guard let userAccount = self.defaults.object(forKey: "UserAccount") as? String else { return nil }
    return userAccount
  }
  
}
