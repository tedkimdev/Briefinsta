//
//  TopMostViewCell.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 28..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

protocol TopMostViewCellType {
  func configure(title: String)
}


final class TopMostViewCell: UITableViewCell, TopMostViewCellType {
  
  // MARK: Constants
  
  fileprivate struct Metric {
    static let dividerLineViewTop: CGFloat = 4.0
    static let dividerLineViewLeftRight: CGFloat = 16.0
    static let dividerLineViewHeight: CGFloat = 1 / UIScreen.main.scale
    
    static let titleLabelTop: CGFloat = 8.0
    static let titleLabelLeftRight: CGFloat = 16.0
    static let titleLabelHeight: CGFloat = Font.titleLabel.lineHeight
    
    static let collectionViewTop: CGFloat = 0.0
    static let collectionViewLeftRight: CGFloat = 16.0
  }
  
  fileprivate struct Font {
    static let titleLabel = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
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
    view.backgroundColor = .bi_lineColor
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
      make.top.equalToSuperview().offset(Metric.dividerLineViewTop)
      make.left.equalToSuperview().offset(Metric.dividerLineViewLeftRight)
      make.right.equalToSuperview().offset(-Metric.dividerLineViewLeftRight)
      make.height.equalTo(Metric.dividerLineViewHeight)
    }
    self.titleLabel.snp.makeConstraints { make in
      make.top.equalTo(self.dividerLineView.snp.top).offset(Metric.titleLabelTop)
      make.left.equalToSuperview().offset(Metric.titleLabelLeftRight)
      make.right.equalToSuperview().offset(-Metric.titleLabelLeftRight)
      make.height.equalTo(Metric.titleLabelHeight)
    }
    self.collectionView.snp.makeConstraints { make in
      make.top.equalTo(self.titleLabel.snp.bottom).offset(Metric.collectionViewTop)
      make.left.equalToSuperview().offset(Metric.collectionViewLeftRight)
      make.right.equalToSuperview().offset(-Metric.collectionViewLeftRight)
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
