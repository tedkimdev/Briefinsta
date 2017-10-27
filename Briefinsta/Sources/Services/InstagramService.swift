//
//  InstagramService.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 25..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Moya

protocol InstagramServiceType {
  func user(with username: String, completion: @escaping (Result<[InstagramMedium]>) -> () )
  func meida(with username: String, offset: String?, completion: @escaping (Result<InstagramMedia>) -> () )
}

final class InstagramService: InstagramServiceType {
  
  private let provider : MoyaProvider<Instagram>
  
  init(
    provider: MoyaProvider<Instagram> = MoyaProvider<Instagram>(plugins: [NetworkLoggerPlugin(verbose: true)])
  ) {
    self.provider = provider
  }
  
  func user(with username: String, completion: @escaping (Result<[InstagramMedium]>) -> () ) {
    provider.request(.user(username: username)) { result in
      switch result {
      case let .success(response):
        let data = response.data // Data, your JSON response is probably in here!
//        let statusCode = response.statusCode // Int - 200, 401, 500, etc
//        print("IntagramService.media")
        
        do {
          try response.filterSuccessfulStatusCodes()
          let instagramMedia = try JSONDecoder().decode(InstagramMedia.self, from: data)
          completion(Result.success(instagramMedia.items))
        }
        catch {
          completion(Result.error(error))
        }

      case let .failure(error):
        completion(Result.error(error))
      }
    }
  }
  
  func meida(with username: String, offset: String?, completion: @escaping (Result<InstagramMedia>) -> () ) {
    provider.request(.user(username: username)) { result in
      switch result {
      case let .success(response):
        let data = response.data
        //        let statusCode = response.statusCode // Int - 200, 401, 500, etc
        
        do {
          try response.filterSuccessfulStatusCodes()
          let instagramMedia = try JSONDecoder().decode(InstagramMedia.self, from: data)
          completion(Result.success(instagramMedia))
        }
        catch {
          completion(Result.error(error))
        }
        
      case let .failure(error):
        completion(Result.error(error))
      }
    }
  }
}
