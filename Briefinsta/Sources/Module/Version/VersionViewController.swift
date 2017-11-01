//
//  VersionViewController.swift
//  Briefinsta
//
//  Created by aney on 2017. 11. 1..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

protocol VersionViewProtocol: class {
  // Presenter -> View
  func displayCurrentVersion(_ value: String)
}


final class VersionViewController: BaseViewController {
  
  // MARK: Constants
  
  fileprivate struct Metric {
    static let iconViewTop: CGFloat = 240.0
    static let iconViewSize: CGFloat = 200.0
    static let iconViewBottom: CGFloat = 0.0
    
    static let currentVersionLabelTop: CGFloat = 30.0
    
    static let lastestVersionLabelTop: CGFloat = 10.0
  }
  
  fileprivate struct Font {
    static let currentVersionLabel = UIFont.systemFont(ofSize: 16)
    
    static let lastestVersionLabel = UIFont.systemFont(ofSize: 16)
  }
  
  
  // MARK: UI
  
  fileprivate let iconView: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "icon-app"))
    imageView.layer.borderColor = UIColor.lightGray.cgColor
    imageView.layer.borderWidth = 1
    imageView.layer.cornerRadius = Metric.iconViewSize * 13.5 / 60
    imageView.layer.minificationFilter = kCAFilterTrilinear
    imageView.clipsToBounds = true
    return imageView
  }()
  
  fileprivate let currentVersionLabel: UILabel = {
    let label = UILabel()
    let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    label.font = Font.currentVersionLabel
    label.text = "Current version \(appVersion)"
    return label
  }()
  
  fileprivate let lastestVersionLabel: UILabel = {
    let label = UILabel()
    label.font = Font.lastestVersionLabel
    label.text = "Lastest version "
    label.textColor = .gray
    return label
  }()
  

  // MARK: Properties
  
  var presenter: VersionPresenterProtocol!

  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.presenter.onViewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tabBarController?.tabBar.isHidden = true
  }
  
  override func setupUI() {
    self.view.backgroundColor = .white
    
    self.navigationItem.largeTitleDisplayMode = .always
    self.navigationItem.title = "Version"
    
    self.view.addSubview(self.iconView)
    self.view.addSubview(self.currentVersionLabel)
    self.view.addSubview(self.lastestVersionLabel)
    
    self.iconView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(Metric.iconViewTop)
      make.centerX.equalToSuperview()
      make.width.height.equalTo(Metric.iconViewSize)
    }
    
    self.currentVersionLabel.snp.makeConstraints { make in
      make.top.equalTo(self.iconView.snp.bottom).offset(Metric.currentVersionLabelTop)
      make.centerX.equalToSuperview()
    }
    
    self.lastestVersionLabel.snp.makeConstraints { make in
      make.top.equalTo(self.currentVersionLabel.snp.bottom).offset(Metric.lastestVersionLabelTop)
      make.centerX.equalToSuperview()
    }
  }
  
  override func setupBinding() {
  }
  
}


// MARK: - VersionViewProtocol

extension VersionViewController: VersionViewProtocol {
  
  func displayCurrentVersion(_ value: String) {
    DispatchQueue.main.async {
      self.lastestVersionLabel.text?.append(contentsOf: value)
    }
  }
  
}
