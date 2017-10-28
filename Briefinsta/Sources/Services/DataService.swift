//
//  DataService.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 26..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

import RealmSwift


enum DataServiceError: Error {
  case readingPostsFailed
  case deletingAllDataFailed
}


protocol DataServiceType {
  func insertPosts(instagramMedia: [InstagramMedium], completion: @escaping (Result<Void>)->())
  func getMostLikedPosts(with limit: Int) -> Result<[InstagramMedium]>
  func getLastWeeksPosts(weeks: Int) -> Result<[InstagramMedium]>
  func getBestEngagementPosts (with limit: Int) -> Result<[InstagramMedium]>
  func deleteAll(completion: @escaping (Result<Void>)->())
}


final class DataService: DataServiceType {
  
  fileprivate func withRealm<T>(_ operation: String, action: (Realm) throws -> T) -> T? {
    do {
      let realm = try Realm()
      return try action(realm)
    } catch let error {
      print("Failed \(operation) realm with error: \(error)")
      return nil
    }
  }
  
  /// Create/save InstagramMediumEntity
  func insertPosts(instagramMedia: [InstagramMedium], completion: @escaping (Result<Void>)->()) {
    let result = self.withRealm("insert posts to realm") { realm -> Result<Void> in
      do {
        try realm.write {
          let objects = instagramMedia.map { InstagramMediumEntity(from: $0) }
          realm.add(objects)
        }
        return Result<Void>.success(Void())
      } catch {
        return Result<Void>.failure(error)
      }
    }
    completion(result!)
  }

  /// Returns the top (n) most liked
  func getMostLikedPosts(with limit: Int) -> Result<[InstagramMedium]> {
    let result = self.withRealm("get the top n most liked media")
    { realm -> Result<[InstagramMedium]> in
      let objects = realm.objects(InstagramMediumEntity.self).sorted(byKeyPath: "commentsCount", ascending: false)
      var limitedObjects = [InstagramMediumEntity]()
      for i in 0..<limit {
        limitedObjects.append(objects[i])
      }
      let media = limitedObjects.map { InstagramMedium.initInstagramMedium(from: $0) }
      return Result.success(media)
    }
    return result ?? Result.failure(DataServiceError.readingPostsFailed)
  }
  
  /// Returns last (n) weeks posted media
  func getLastWeeksPosts(weeks: Int) -> Result<[InstagramMedium]> {
    let result = self.withRealm("get last week media")
    { realm -> Result<[InstagramMedium]> in
      let date = Calendar.current.date(byAdding: .day, value: -(weeks * 7), to: Date())! as NSDate
      let predicate = NSPredicate(format: "createdTime > %@", date)
      let objects = realm.objects(InstagramMediumEntity.self).filter(predicate).sorted(byKeyPath: "createdTime", ascending: false)
      let media = Array(objects).map { InstagramMedium.initInstagramMedium(from: $0) }
      return Result.success(media)
    }
    return result ?? Result.failure(DataServiceError.readingPostsFailed)
  }
  
  /// Returns the top (n) best engagement
  func getBestEngagementPosts (with limit: Int) -> Result<[InstagramMedium]> {
    let result = self.withRealm("get the top n engagement media")
    { realm -> Result<[InstagramMedium]> in
      let objects = realm.objects(InstagramMediumEntity.self).sorted(byKeyPath: "engagementCount", ascending: false)
      var limitedObjects = [InstagramMediumEntity]()
      for i in 0..<limit {
        limitedObjects.append(objects[i])
      }
      let media = limitedObjects.map { InstagramMedium.initInstagramMedium(from: $0) }
      return Result.success(media)
    }
    return result ?? Result.failure(DataServiceError.readingPostsFailed)
  }
  
  /// Delete all posts data
  func deleteAll(completion: @escaping (Result<Void>)->()) {
    do {
      let realm = try Realm()
      try realm.write {
        realm.deleteAll()
      }
    } catch {
      completion(Result.failure(error))
    }
    completion(Result.success(Void()))
  }
  
}