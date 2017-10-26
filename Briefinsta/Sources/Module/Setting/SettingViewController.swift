//
//  SettingViewController.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 25..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

protocol SettingViewProtocol: class {
  // Presenter -> View
  func startNetworking()
  func stopNetworking()
}

final class SettingViewController: BaseViewController {
  
  // MARK: Metric
  
  private struct Metric {
    
  }
  
  
  // MARK: Properties
  
  var presenter: SettingPresenterProtocol!
  
  
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
  
  override func setupUI() {
    self.navigationItem.title = "Setting"
    
    self.tableView.tableFooterView = UIView()
    self.tableView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
    
    self.tableView.register(SettingViewTableCell.self, forCellReuseIdentifier: "SettingViewTableCell")
    
    self.view.addSubview(self.tableView)
  }
  
  override func setupBinding() {
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }
  
}


// MARK: - SettingViewProtocol

extension SettingViewController: SettingViewProtocol {
  
  func startNetworking() {
    
  }
  
  func stopNetworking() {
    
  }
  
}


// MARK: - UITableViewDelegate

extension SettingViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("\(indexPath.row)")
  }
}


// MARK: - UITableViewDatasource

extension SettingViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SettingViewTableCell", for: indexPath) as! SettingViewTableCell
    
    return cell
  }
  
}
