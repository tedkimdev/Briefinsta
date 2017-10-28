//
//  AddUserAccountViewController.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 26..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

protocol AddUserAccountViewProtocol: class {
  // Presenter -> View
}

final class AddUserAccountViewController: BaseViewController {
  
  // MARK: Constants
  
  fileprivate struct Metric {
    static let headerHeight: CGFloat = 80.0
    static let rowHeight: CGFloat = 40.0
  }
  
  
  // MARK: Properties
  
  var presenter: AddUserAccountPresenterProtocol!
  private var username: String?
  
  // MARK: UI
  
  let tableView: UITableView = {
    let tableView = UITableView(
      frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height),
      style: .grouped)
    return tableView
  }()
  
  var doneButton: UIBarButtonItem!
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    self.usernameTextfield.becomeFirstResponder()
//    self.interactor?.loadAccount()
    self.presenter.onViewDidLoad()
  }
  
  override func setupUI() {
    self.view.backgroundColor = .bi_headerBackground
    
    self.navigationItem.largeTitleDisplayMode = .always
    self.navigationItem.title = "Add User Account"
    
    self.tableView.tableFooterView = UIView()
    self.tableView.backgroundColor = .bi_headerBackground//UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
    self.tableView.register(AddUserAccountHeaderFooter.self, forCellReuseIdentifier: "AddUserAccountHeaderFooter")
    self.tableView.register(AddUserAccountCell.self, forCellReuseIdentifier: "AddUserAccountCell")
    self.tableView.isScrollEnabled = false
    
    self.view.addSubview(self.tableView)
    
    self.doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonDidTap(_:)))
    
    self.navigationItem.rightBarButtonItem = self.doneButton
  }
  
  override func setupBinding() {
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }
  
  
  // MARK: Actions
  
  @objc fileprivate func doneButtonDidTap(_ senter: Any) {
    guard let username = self.username, !username.isEmpty else {
      return
    }
    self.presenter.validateUserAccount(with: username)
  }
}


// MARK: - AddUserAccountViewProtocol

extension AddUserAccountViewController: AddUserAccountViewProtocol {
}


// MARK: - UITableViewDelegate

extension AddUserAccountViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    self.presenter.didSelectTableViewRowAt(indexPath: indexPath)
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return Metric.headerHeight
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return Metric.headerHeight
  }
  
}


// MARK: - UITableViewDatasource

extension AddUserAccountViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.presenter.numberOfSections()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.presenter.numberOfRows(in: section)
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeueReusableCell(withIdentifier: "AddUserAccountHeaderFooter") as! AddUserAccountHeaderFooter
    self.presenter.configureHeader(header, in: section)
    return header
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footer = tableView.dequeueReusableCell(withIdentifier: "AddUserAccountHeaderFooter") as! AddUserAccountHeaderFooter
    self.presenter.configureFooter(footer, in: section)
    return footer
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "AddUserAccountCell", for: indexPath) as! AddUserAccountCell
    
    // TODO: viewController? presenter?
    cell.textDidChange = { [weak self] username in
      guard let `self` = self else { return }
      self.username = username
    }
    
    return cell
  }
  
}
