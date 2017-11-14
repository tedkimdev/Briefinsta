//
//  AppStoreAPI.swift
//  Briefinsta
//
//  Created by aney on 2017. 11. 1..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

import Moya

enum AppStoreAPI {
  case lookup(bundleID: String)
}


// MARK: - TargetType Protocol Implementation

extension AppStoreAPI: TargetType {
  
  var baseURL: URL { return URL(string: "https://itunes.apple.com/kr")! }
  
  var path: String {
    switch self {
    case .lookup:
      return "/lookup"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .lookup:
      return .get
    }
  }

  var task: Task {
    switch self {
    case let .lookup(bundleID):
      return .requestParameters(parameters: ["bundleId": bundleID], encoding: URLEncoding())
    }
  }
  
  var headers: [String : String]? {
    return nil
  }
  
  var sampleData: Data {
    return Data()
  }
  
}
