//
//  InstagramMedia.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 25..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

struct InstagramMedium: Decodable {
  
  let id: String
  let code: String
  let username: String
  let imageURL: String
  let likesCount: Int
  let commentsCount: Int
  let engagementCount: Int
  let type: String

  enum CodingKeys: String, CodingKey {
    case id = "id"
    case code = "code"
    case username = "user"
    case type = "type"
    case imageURL = "images"
    case likesCount = "likes"
    case commentsCount = "comments"
  }
  
  enum LikesCodingKeys: String, CodingKey {
    case count = "count"
  }
  enum CommentsCodingKeys: String, CodingKey {
    case count = "count"
  }
  
}

extension InstagramMedium {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    let id = try container.decode(String.self, forKey: .id)
    let code = try container.decode(String.self, forKey: .code)
    let user = try container.decode(User.self, forKey: .username)
    let username = user.username
    let image = try container.decode(Images.self, forKey: .imageURL)
    let imageURL = image.lowResolutionImage.imageURL
    
    let likesContainer = try container.nestedContainer(keyedBy: LikesCodingKeys.self, forKey: .likesCount)
    let likesCount = try likesContainer.decode(Int.self, forKey: .count)
    let commentsContainer = try container.nestedContainer(keyedBy: CommentsCodingKeys.self, forKey: .commentsCount)
    let commentsCount = try commentsContainer.decode(Int.self, forKey: .count)
    let engagementCount = likesCount + commentsCount
    let type = try container.decode(String.self, forKey: .type)
    
    self.init(id: id, code: code, username: username, imageURL: imageURL, likesCount: likesCount, commentsCount: commentsCount, engagementCount: engagementCount, type: type)
  }
}


// MARK: InstagramMedia

struct InstagramMedia: Decodable {
  let items: [InstagramMedium]
  enum CodingKeys: String, CodingKey {
    case items = "items"
  }
}


struct User: Decodable {
  let id: String
  let fullname: String
  let username: String
  let profileURL: String
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case fullname = "full_name"
    case username = "username"
    case profileURL = "profile_picture"
  }
}


struct Images: Decodable {
  let lowResolutionImage: Image
  enum CodingKeys: String, CodingKey {
    case lowResolutionImage = "low_resolution"
  }
}

struct Image: Decodable {
  let width: Float
  let height: Float
  let imageURL: String
  enum CodingKeys: String, CodingKey {
    case width = "width"
    case height = "height"
    case imageURL = "url"
  }
}
