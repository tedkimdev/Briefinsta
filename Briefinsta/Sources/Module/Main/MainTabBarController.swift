//
//  MainTabBarController.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 28..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

protocol MainTabBarViewProtocol: class {
  // Presenter -> View
}

final class MainTabBarViewController: UITabBarController {
  
  // MARK: Metric
  
  // MARK: Properties
  
//  var presenter: MainTabBarPresenterProtocol!
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupUI()
    self.setupBinding()
  }
  
  func setupUI() {
  }
  
  func setupBinding() {
  }
  
}


// MARK: - MainTabBarViewProtocol

extension MainTabBarViewController: MainTabBarViewProtocol {
}
