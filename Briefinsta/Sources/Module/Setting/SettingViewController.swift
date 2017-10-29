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
  func reloadUI()
  func displayAlertInput()
}

final class SettingViewController: BaseViewController {
  
  // MARK: Constants
  
  fileprivate struct Metric {
    static let headerHeight: CGFloat = 50.0
    static let rowHeight: CGFloat = 40.0
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
  
  
  // MARK: Initializing
  
  init() {
    super.init(nibName: nil, bundle: nil)
    self.title = "Settings"
    self.tabBarItem.image = UIImage(named: "icon-settings")
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.presenter.onViewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tabBarController?.tabBar.isHidden = false
  }
  
  override func setupUI() {
    self.navigationItem.largeTitleDisplayMode = .always
    self.navigationItem.title = "Setting"
    
    self.tableView.tableFooterView = UIView()
    self.view.backgroundColor = .bi_headerBackground
    self.tableView.backgroundColor = .bi_headerBackground//UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
    self.tableView.register(SettingViewHeader.self, forCellReuseIdentifier: "SettingViewHeader")
    self.tableView.register(SettingViewTableCell.self, forCellReuseIdentifier: "SettingViewTableCell")
//    self.tableView.isScrollEnabled = false
    
    self.view.addSubview(self.tableView)
  }
  
  override func setupBinding() {
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }
  
}


// MARK: - SettingViewProtocol

extension SettingViewController: SettingViewProtocol {
  
  func reloadUI() {
    self.tableView.reloadData()
  }
  
  func displayAlertInput() {
    let alertController = UIAlertController(title: "Collecting media", message: "maximum media to collect", preferredStyle: .alert)

    let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
      guard let text = alertController.textFields?.first?.text,
        let value = Int(text) else { return }

      self.presenter.changeMaxMediaNumber(value)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
    
    alertController.addTextField { (textField) in
      textField.placeholder = "Enter number"
    }
    
    alertController.addAction(confirmAction)
    alertController.addAction(cancelAction)
    
    self.present(alertController, animated: true, completion: nil)
  }
  
}


// MARK: - UITableViewDelegate

extension SettingViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    self.presenter.didSelectTableViewRowAt(indexPath: indexPath)
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if section == 3 {
      return 0.0
    }
    return Metric.headerHeight
  }
  
}


// MARK: - UITableViewDatasource

extension SettingViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.presenter.numberOfSections()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.presenter.numberOfRows(in: section)
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeueReusableCell(withIdentifier: "SettingViewHeader") as! SettingViewHeader
    self.presenter.configureHeader(header, in: section)
    return header
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SettingViewTableCell", for: indexPath) as! SettingViewTableCell
    self.presenter.configureCell(cell, for: indexPath)
    return cell
  }
  
}
