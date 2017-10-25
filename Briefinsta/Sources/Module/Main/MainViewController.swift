//
//  MainViewController.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 24..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

protocol MainViewProtocol: class {
  // Presenter -> View
  func startNetworking()
  func stopNetworking()
}

final class MainViewController: BaseViewController {
  
  // MARK: Metric
  
  // MARK: Properties
  
  var presenter: MainPresenterProtocol!
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func setupUI() {
    self.view.backgroundColor = .yellow
  }
  
  override func setupBinding() {
    
  }
  
}


// MARK: - MainViewProtocol

extension MainViewController: MainViewProtocol {
  
  func startNetworking() {
    
  }
  
  func stopNetworking() {
    
  }
  
}
