//
//  InstagramService.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 25..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

import Moya

enum Instagram {
  case media(username: String)
}


// MARK: - TargetType Protocol Implementation

extension Instagram: TargetType {
  var baseURL: URL { return URL(string: "https://www.instagram.com")! }
  
  var path: String {
    switch self {
    case .media(let username):
      return "/\(username)/media"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .media:
      return .get
    }
  }
  
  var task: Task {
    switch self {
    case .media(_):
      return .requestPlain//.requestParameters(parameters: ["user_name": username], encoding: URLEncoding.queryString)
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var headers: [String: String]? {
    return ["Content-type": "application/json"]
  }
  
}


// MARK: - Helpers

private extension String {
  var urlEscaped: String {
    return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
  }
  
  var utf8Encoded: Data {
    return data(using: .utf8)!
  }
}
