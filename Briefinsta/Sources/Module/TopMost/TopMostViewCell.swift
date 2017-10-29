//
//  TopMostViewCell.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 28..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

final class TopMostViewCell: UITableViewCell {
  
  // MARK: Constants
  
  fileprivate struct Font {
    static let titleLabel = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.heavy)
  }
  
  
  // MARK: UI
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.font = Font.titleLabel
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = UIColor.clear
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  let dividerLineView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  
  // MARK: Initializing
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate func setupUI() {
    self.collectionView.register(InstagramMediumCell.self, forCellWithReuseIdentifier: "InstagramMediumCell")
    
    self.contentView.backgroundColor = UIColor.clear
    self.addSubview(self.collectionView)
    self.addSubview(self.dividerLineView)
    self.addSubview(self.titleLabel)
    
    self.dividerLineView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(4)
      make.left.equalToSuperview()
      make.right.equalToSuperview()
      make.height.equalTo(1 / UIScreen.main.scale)
    }
    self.titleLabel.snp.makeConstraints { make in
      make.top.equalTo(self.dividerLineView.snp.top).offset(8)
      make.left.equalToSuperview().offset(20)
      make.right.equalToSuperview().offset(-20)
      make.height.equalTo(40)
    }
    self.collectionView.snp.makeConstraints { make in
      make.top.equalTo(self.titleLabel.snp.bottom).offset(4)
      make.left.equalToSuperview().offset(20)
      make.right.equalToSuperview().offset(-20)
      make.bottom.equalToSuperview()
    }
  }
  
  
  // MARK: Configuring
  
  func configure(title: String) {
    self.titleLabel.text = title
  }
  
}


// MARK: - CollectionView Delegate DataSource

extension TopMostViewCell {
  
  func setCollectionViewDelegateDataSource(
    delegate: UICollectionViewDelegate,
    dataSource: UICollectionViewDataSource,
    rowAt indexPath: IndexPath
  ) {
    self.collectionView.delegate = delegate
    self.collectionView.dataSource = dataSource
    self.collectionView.tag = indexPath.row
    
    self.collectionView.reloadData()
  }
  
}
