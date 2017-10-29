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
  func media(with username: String, offset: String?, completion: @escaping (Result<InstagramMedia>) -> () )
}


final class InstagramService: InstagramServiceType {
  
  private let provider : MoyaProvider<Instagram>
  
  init(
    provider: MoyaProvider<Instagram> = MoyaProvider<Instagram>(plugins: [NetworkLoggerPlugin(verbose: true)])
  ) {
    self.provider = provider
  }
  
  func user(with username: String, completion: @escaping (Result<[InstagramMedium]>) -> () ) {
    provider.request(.user(username)) { result in
      switch result {
      case let .success(response):
        let data = response.data
        do {
          let instagramMedia = try JSONDecoder().decode(InstagramMedia.self, from: data)
          completion(Result.success(instagramMedia.items))
        }
        catch {
          completion(Result.failure(error))
        }

      case let .failure(error):
        completion(Result.failure(error))
      }
    }
  }
  
  func media(with username: String, offset: String?, completion: @escaping (Result<InstagramMedia>) -> () ) {
    provider.request(.media(username, offset)) { result in
      switch result {
      case let .success(response):
        let data = response.data
        do {
          let instagramMedia = try JSONDecoder().decode(InstagramMedia.self, from: data)
          completion(Result.success(instagramMedia))
        }
        catch {
          completion(Result.failure(error))
        }
        
      case let .failure(error):
        completion(Result.failure(error))
      }
    }
  }
}
