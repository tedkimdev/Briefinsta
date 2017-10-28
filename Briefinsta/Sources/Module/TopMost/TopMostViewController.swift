//
//  TopMostViewController.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 28..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

protocol TopMostViewProtocol: class {
  // Presenter -> View
  func displayLoadedMedia()
}


final class TopMostViewController: BaseViewController {
  
  // MARK: Constants
  
  fileprivate struct Metric {
  }
  
  
  // MARK: Properties
  
  var presenter: TopMostPresenterProtocol!
  
  
  // MARK: UI
  
  let tableView: UITableView = {
    let tableView = UITableView(
      frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height),
      style: .grouped)
    return tableView
  }()
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.presenter.onViewDidLoad()
  }
  
  
  // MARK: Initializing
  
  init() {
    super.init(nibName: nil, bundle: nil)
    self.tabBarItem.image = UIImage(named: "icon-setting")
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setupUI() {
    self.navigationItem.largeTitleDisplayMode = .always
    self.navigationItem.title = "Report🦊"
    
    self.view.backgroundColor = .white
    
    self.tableView.tableFooterView = UIView()
    self.view.backgroundColor = .green
    self.tableView.backgroundColor = .white
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
//    self.tableView.register(SettingViewTableCell.self, forCellReuseIdentifier: "SettingViewTableCell")
    //    self.tableView.isScrollEnabled = false
    
    self.view.addSubview(self.tableView)
  }
  
  override func setupBinding() {
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }
  
}


// MARK: - TopMostViewProtocol

extension TopMostViewController: TopMostViewProtocol {
  
  func displayLoadedMedia() {
    print("TopMostViewController.displayLoadedMedia")
  }
  
}


// MARK: - UITableViewDelegate

extension TopMostViewController: UITableViewDelegate {
  
}


// MARK: - UITableViewDataSource

extension TopMostViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 7
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    
    cell.backgroundColor = .green
    
    return cell
  }
  
}
