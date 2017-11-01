//
//  AppInformation.swift
//  Briefinsta
//
//  Created by aney on 2017. 11. 1..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

struct AppInformation: Decodable {
  
  let version: String
  
  enum CodingKeys: String, CodingKey {
    case version = "version"
  }
  
}


//extension AppInformation {
//  init(from decoder: Decoder) throws {
//    let container = try decoder.container(keyedBy: CodingKeys.self)
//
//    let version = try container.decode(String.self, forKey: .id)
//    let code = try container.decode(String.self, forKey: .code)
//    let user = try container.decode(User.self, forKey: .username)
//    let username = user.username
//    let image = try container.decode(Images.self, forKey: .imageURL)
//    let imageURL = image.lowResolutionImage.imageURL
//
//    let likesContainer = try container.nestedContainer(keyedBy: LikesCodingKeys.self, forKey: .likesCount)
//    let likesCount = try likesContainer.decode(Int.self, forKey: .count)
//    let commentsContainer = try container.nestedContainer(keyedBy: CommentsCodingKeys.self, forKey: .commentsCount)
//    let commentsCount = try commentsContainer.decode(Int.self, forKey: .count)
//    let engagementCount = likesCount + commentsCount
//
//    let creationDateString = try container.decode(String.self, forKey: .createdTime)
//    let unixTimestamp = Date(timeIntervalSince1970: TimeInterval(creationDateString)!)
//    let createdTime = unixTimestamp
//
//    let type = try container.decode(String.self, forKey: .type)
//
//    self.init(id: id, code: code, username: username, imageURL: imageURL, likesCount: likesCount, commentsCount: commentsCount, engagementCount: engagementCount, createdTime: createdTime, type: type)
//  }
//}
//
//
//{
//  "resultCount":1,
//  "results": [
//  {"ipadScreenshotUrls":[], "appletvScreenshotUrls":[], "artworkUrl512":"http://is1.mzstatic.com/image/thumb/Purple128/v4/e4/42/ea/e442ea94-1bec-db3c-9471-48639df6e712/source/512x512bb.jpg", "artworkUrl60":"http://is1.mzstatic.com/image/thumb/Purple128/v4/e4/42/ea/e442ea94-1bec-db3c-9471-48639df6e712/source/60x60bb.jpg", "artworkUrl100":"http://is1.mzstatic.com/image/thumb/Purple128/v4/e4/42/ea/e442ea94-1bec-db3c-9471-48639df6e712/source/100x100bb.jpg", "artistViewUrl":"https://itunes.apple.com/us/developer/taedong-kim/id1288229502?uo=4", "isGameCenterEnabled":false, "kind":"software", "features":[],
//  "supportedDevices":["iPhone5s-iPhone5s", "iPadAir-iPadAir", "iPadAirCellular-iPadAirCellular", "iPadMiniRetina-iPadMiniRetina", "iPadMiniRetinaCellular-iPadMiniRetinaCellular", "iPhone6-iPhone6", "iPhone6Plus-iPhone6Plus", "iPadAir2-iPadAir2", "iPadAir2Cellular-iPadAir2Cellular", "iPadMini3-iPadMini3", "iPadMini3Cellular-iPadMini3Cellular", "iPodTouchSixthGen-iPodTouchSixthGen", "iPhone6s-iPhone6s", "iPhone6sPlus-iPhone6sPlus", "iPadMini4-iPadMini4", "iPadMini4Cellular-iPadMini4Cellular", "iPadPro-iPadPro", "iPadProCellular-iPadProCellular", "iPadPro97-iPadPro97", "iPadPro97Cellular-iPadPro97Cellular", "iPhoneSE-iPhoneSE", "iPhone7-iPhone7", "iPhone7Plus-iPhone7Plus", "iPad611-iPad611", "iPad612-iPad612", "iPad71-iPad71", "iPad72-iPad72", "iPad73-iPad73", "iPad74-iPad74", "iPhone8-iPhone8", "iPhone8Plus-iPhone8Plus", "iPhoneX-iPhoneX"],
//  "screenshotUrls":["http://is1.mzstatic.com/image/thumb/Purple128/v4/ec/30/50/ec30501b-5641-0488-e9b3-b1e68ce37a64/source/392x696bb.jpg", "http://is3.mzstatic.com/image/thumb/Purple128/v4/28/1a/2f/281a2f58-a371-2db5-08d2-6ef0369d6c4e/source/392x696bb.jpg", "http://is1.mzstatic.com/image/thumb/Purple128/v4/52/35/70/523570f1-8481-253a-8156-f5c86fd292b4/source/392x696bb.jpg"], "advisories":[], "languageCodesISO2A":["EN"], "fileSizeBytes":"15942656", "trackContentRating":"4+", "trackCensoredName":"Briefinsta", "trackViewUrl":"https://itunes.apple.com/us/app/briefinsta/id1303221657?mt=8&uo=4", "contentAdvisoryRating":"4+", "formattedPrice":"Free", "genreIds":["6012", "6005"], "currentVersionReleaseDate":"2017-11-01T17:33:14Z", "currency":"USD", "wrapperType":"software", "version":"0.1.3", "description":"It's an application to make a best posts list for Instagram.\nInput public Instagram ID and make the best posts list.", "artistId":1288229502, "artistName":"TAEDONG KIM", "genres":["Lifestyle", "Social Networking"], "price":0.00, "trackId":1303221657, "trackName":"Briefinsta", "bundleId":"com.aney00.Briefinsta", "primaryGenreName":"Lifestyle", "isVppDeviceBasedLicensingEnabled":true, "releaseDate":"2017-11-01T17:33:14Z", "primaryGenreId":6012, "minimumOsVersion":"11.0", "sellerName":"TAEDONG KIM"}]
//}

