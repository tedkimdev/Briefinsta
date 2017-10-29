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
  
  func setUserAccount(value: String?) {
    guard let value = value else {
      self.defaults.removeObject(forKey: "UserAccount")
      self.defaults.synchronize()
      return
    }
    self.defaults.set(value, forKey: "UserAccount")
    self.defaults.synchronize()
  }
  
  func getUserAccount() -> String? {
    guard let userAccount = self.defaults.object(forKey: "UserAccount") as? String else { return nil }
    return userAccount
  }
  
  func setMaxColletingPosts(value: Int?) {
    guard let value = value else {
      self.defaults.set(1000, forKey: "MaxColletingPosts")
      self.defaults.synchronize()
      return
    }
    self.defaults.set(value, forKey: "MaxColletingPosts")
    self.defaults.synchronize()
  }
  
  func getMaxColletingPosts() -> Int? {
    guard let maxPosts = self.defaults.object(forKey: "MaxColletingPosts") as? Int else { return nil }
    return maxPosts
  }
  
}
