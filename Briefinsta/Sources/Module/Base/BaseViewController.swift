//
//  BaseViewController.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 24..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  
  // MARK: Initializing
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupBinding()
  }

  func setupUI() {
    // Override
  }
  
  func setupBinding() {
    // Override
  }
  
  // MARK: Memory Warning & Deinit
  
  override func didReceiveMemoryWarning() {
    // print("\(self) did Receive Memory Warning")
  }
  
  deinit {
    // print("\(self) has deinitialized")
  }
}

