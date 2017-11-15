//
//  Media.swift
//  Briefinsta
//
//  Created by aney on 2017. 11. 14..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation


struct Media: Decodable {
  let items: [Medium]
  let count: Int
  let moreAvailable: Bool
  
  enum CodingKeys: String, CodingKey {
    case items = "nodes"
    case count = "count"
    case moreAvailable = "page_info"
  }
}


extension Media {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    let items = try container.decode([Medium].self, forKey: .items)
    let count = try container.decode(Int.self, forKey: .count)
    let pageInfomation = try container.decode(PageInformation.self, forKey: .moreAvailable)
    let moreAvailable = pageInfomation.hasNextPage
    
    self.init(items: items, count: count, moreAvailable: moreAvailable)
  }
}


struct InstagramMediaAPIResult: Decodable {
  let user: User
  
  enum CodingKeys: String, CodingKey {
    case user = "user"
  }
}


struct User: Decodable {
  let id: String
  let fullname: String
  let username: String
  let profileURL: String
  let media: Media
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case fullname = "full_name"
    case username = "username"
    case profileURL = "profile_pic_url_hd"
    case media = "media"
  }
  
}


struct PageInformation: Decodable {
  let hasNextPage: Bool
  
  enum CodingKeys: String, CodingKey {
    case hasNextPage = "has_next_page"
  }
}


struct Medium: Decodable {
  let id: String
  let code: String
  let imageURL: String
  let likesCount: Int
  let commentsCount: Int
  let engagementCount: Int
  let createdTime: Date
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case code = "code"
    case imageURL = "display_src"
    case likesCount = "likes"
    case commentsCount = "comments"
    case createdTime = "date"
  }
  
  enum LikesCodingKeys: String, CodingKey {
    case count = "count"
  }
  enum CommentsCodingKeys: String, CodingKey {
    case count = "count"
  }
  
  static func initMedium(from entity: InstagramMediumEntity) -> Medium {
    return Medium(
      id: entity.id,
      code: entity.code,
      imageURL: entity.imageURL,
      likesCount: entity.likesCount,
      commentsCount: entity.commentsCount,
      engagementCount: entity.engagementCount,
      createdTime: entity.createdTime
    )
  }
  
}


extension Medium {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    let id = try container.decode(String.self, forKey: .id)
    let code = try container.decode(String.self, forKey: .code)
    let imageURL = try container.decode(String.self, forKey: .imageURL)
    
    let likesContainer = try container.nestedContainer(keyedBy: LikesCodingKeys.self, forKey: .likesCount)
    let likesCount = try likesContainer.decode(Int.self, forKey: .count)
    
    let commentsContainer = try container.nestedContainer(keyedBy: CommentsCodingKeys.self, forKey: .commentsCount)
    let commentsCount = try commentsContainer.decode(Int.self, forKey: .count)
    
    let engagementCount = likesCount + commentsCount
    
    let creationDateTime = try container.decode(TimeInterval.self, forKey: .createdTime)
    let unixTimestamp = Date(timeIntervalSince1970: creationDateTime)
    let createdTime = unixTimestamp
    
    self.init(id: id, code: code, imageURL: imageURL, likesCount: likesCount, commentsCount: commentsCount, engagementCount: engagementCount, createdTime: createdTime)
  }
}
