//
//  TopMostInteractor.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 28..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

protocol TopMostInteractorInputProtocol: class {
  // Presenter -> Interactor
  func loadInstagramMedia()
}


final class TopMostInteractor {
  
  // MARK: Properties
  
  weak var presenter: TopMostInteractorOutputProtocol!
  
  private let dataService: DataServiceType
  private let settings: Settings
  
  private var userAccount: String?
  
  
  // MARK: Initializing
  
  init(dataService: DataServiceType, settings: Settings) {
    self.dataService = dataService
    self.settings = settings
    
    NotificationCenter.default.addObserver(self, selector: #selector(loadStoredData), name: Notification.Name(rawValue:"analysisCompleted"), object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(loadInstagramMedia), name: Notification.Name(rawValue:"allDataDeleted"), object: nil)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc fileprivate func loadStoredData() {
    do {
      let bestEngagement = try self.dataService.getBestEngagementPosts(with: 25)
      let mostCommented = try self.dataService.getMostCommentedPosts(with: 25)
      let mostLiked = try self.dataService.getMostLikedPosts(with: 25)
      let recentPosted = try self.dataService.getLastWeeksPosts(weeks: 12) // about 3 months

      self.presenter.presentLoadedSection(media:
        [
          TopMostViewSection(title: "Best Posts", items: bestEngagement.map { InstagramMediaViewModel($0) }),
          TopMostViewSection(title: "Most Commented Posts", items: mostCommented.map { InstagramMediaViewModel($0) }),
          TopMostViewSection(title: "Most Liked Posts", items: mostLiked.map { InstagramMediaViewModel($0) }),
          TopMostViewSection(title: "Recent Posts", items: recentPosted.map { InstagramMediaViewModel($0) }),
        ]
      )
    } catch {
      self.presenter.presentAlertController(with: error.localizedDescription)
    }
  }
  
}


// MARK: - InteractorInputProtocol

extension TopMostInteractor: TopMostInteractorInputProtocol {
  
  @objc func loadInstagramMedia() {
    guard let userAccount = self.settings.getUserAccount() else {
      self.presenter.presentEmptySection()
      return
    }
    self.userAccount = userAccount
    self.loadStoredData()
  }
  
}
