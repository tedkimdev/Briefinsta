//
//  InstagramService.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 25..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Moya

protocol InstagramServiceType {
  func user(with username: String, completion: @escaping (Result<[Medium]>) -> () )
  func media(with username: String, offset: String?, completion: @escaping (Result<Media>) -> () )
}


final class InstagramService: InstagramServiceType {
  
  private let provider : MoyaProvider<InstagramAPI>
  
  init(
    provider: MoyaProvider<InstagramAPI> = MoyaProvider<InstagramAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
  ) {
    self.provider = provider
  }
  
  func user(with username: String, completion: @escaping (Result<[Medium]>) -> () ) {
    provider.request(.user(username)) { result in
      switch result {
      case let .success(response):
        let data = response.data
        do {
          let apiResult = try JSONDecoder().decode(InstagramMediaAPIResult.self, from: data)
          let media = apiResult.user.media.items
          completion(Result.success(media))
        }
        catch {
          completion(Result.failure(error))
        }
      case let .failure(error):
        completion(Result.failure(error))
      }
    }
  }
  
  func media(with username: String, offset: String?, completion: @escaping (Result<Media>) -> () ) {
    provider.request(.media(username, offset)) { result in
      switch result {
      case let .success(response):
        let data = response.data
        do {
          let apiResult = try JSONDecoder().decode(InstagramMediaAPIResult.self, from: data)
          let media = apiResult.user.media
          completion(Result.success(media))
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
