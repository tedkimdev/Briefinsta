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
  
//  override func viewDidAppear(_ animated: Bool) {
//    <#code#>
//  }
  
  // MARK: Initializing
  
  init() {
    super.init(nibName: nil, bundle: nil)
    self.title = "Brief report"
    self.tabBarItem.image = UIImage(named: "icon-details")
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setupUI() {
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationItem.largeTitleDisplayMode = .always
    self.navigationItem.title = "Briefinsta 📸"
    
    self.view.backgroundColor = .white
    
    self.tableView.allowsSelection = false
    self.tableView.tableFooterView = UIView()
    self.tableView.separatorStyle = .none
    self.tableView.backgroundColor = .white
    self.tableView.register(TopMostViewCell.self, forCellReuseIdentifier: "TopMostViewCell")
    
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
    self.tableView.reloadData()
  }
  
}


// MARK: - UITableViewDelegate

extension TopMostViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return CGFloat(300.0)
  }
  
}


// MARK: - UITableViewDataSource

extension TopMostViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.presenter.numberOfSections()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.presenter.numberOfRows(in: section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TopMostViewCell", for: indexPath) as! TopMostViewCell
    self.presenter.configureCell(cell, for: indexPath)
    cell.setCollectionViewDelegateDataSource(delegate: self, dataSource: self, rowAt: indexPath)
    return cell
  }
  
}


// MARK: - TopMostViewCell UICollectionViewDelegate

extension TopMostViewController: UICollectionViewDelegateFlowLayout {
 
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 4.0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (self.view.bounds.width - 8.0) / 3, height:(self.view.bounds.width - 8.0) / 3 + 50)
  }
  
}


// MARK: - TopMostViewCell UICollectionViewDataSource

extension TopMostViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.presenter.numberOfItemsInSection(in: section)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstagramMediumCell", for: indexPath) as! InstagramMediumCell
    self.presenter.configureMediumCell(cell, in: collectionView.tag, for: indexPath)
    
    return cell
  }
  
}
