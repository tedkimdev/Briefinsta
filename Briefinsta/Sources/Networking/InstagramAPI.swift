//
//  InstagramService.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 25..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

import Moya

enum InstagramAPI {
  case user(String)
  case media(String, String?)
}


// MARK: - TargetType Protocol Implementation

extension InstagramAPI: TargetType {
  var baseURL: URL { return URL(string: "https://www.instagram.com")! }
  var path: String {
    switch self {
    case .user(let username):
      return "/\(username)"
    case .media(let username, _):
      return "/\(username)"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .user:
      return .get
    case .media:
      return .get
    }
  }
  
  var parameters: [String: Any] {
    switch self {
    case let .media(_, offset):
      return ["__a": 1, "max_id": offset ?? ""]
    default:
      return ["__a": 1]
    }
  }
  
  var task: Task {
    switch self {
    case .user:
      return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    case .media(_, _):
      return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
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
