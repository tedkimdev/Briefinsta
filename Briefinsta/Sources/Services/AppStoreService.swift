//
//  AppStoreService.swift
//  Briefinsta
//
//  Created by aney on 2017. 11. 1..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Moya

protocol AppStoreServiceType {
  func latestVersion(completion: @escaping (Result<String>) -> ())
}

final class AppStoreService: AppStoreServiceType {
//  fileprivate let networking = Networking<AppStoreAPI>()
  
  
  private let provider : MoyaProvider<AppStoreAPI>
  
  init(
    provider: MoyaProvider<AppStoreAPI> = MoyaProvider<AppStoreAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
    ) {
    self.provider = provider
  }
  
  func latestVersion(completion: @escaping (Result<String>) -> ()) {
    guard let bundleID = Bundle.main.bundleIdentifier else { return }
    provider.request(.lookup(bundleID: bundleID)) { result in
      switch result {
      case .success(let value):
        do {
          guard let json = try value.mapJSON() as? [String: Any] else { return }
          guard let results = json["results"] as? [[String: Any]] else { return }
          guard let version = results.first!["version"] as? String else { return }
          completion(Result.success(version))
        } catch {
          completion(Result.failure(ServiceError.error))
        }
        
      case .failure(let error):
        completion(Result.failure(error))
      }
      
    }
  }
  
}
