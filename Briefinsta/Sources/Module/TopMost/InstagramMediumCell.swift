//
//  InstagramMediumCell.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 28..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

final class InstagramMediumCell: UICollectionViewCell {
  
  // MARK: Initializing
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: UI
  
  let imageView: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    image.layer.cornerRadius = 8
    image.layer.masksToBounds = true
    return image
  }()
  
  let likeImageView: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    image.layer.masksToBounds = true
    image.tintColor = .red
    image.image = UIImage(named: "icon-heart")?.withRenderingMode(.alwaysTemplate)
    return image
  }()
  
  let commentImageView: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    image.layer.masksToBounds = true
    image.tintColor = .red
    image.image = UIImage(named: "icon-comment")
    return image
  }()
  
  let likesLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
    return label
  }()
  
  let commentsLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
    label.textColor = UIColor.lightGray
    return label
  }()
  
  fileprivate func setupUI() {
    self.addSubview(self.imageView)
    self.addSubview(self.likeImageView)
    self.addSubview(self.likesLabel)
    self.addSubview(self.commentImageView)
    self.addSubview(self.commentsLabel)
    self.imageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.width)
    self.likeImageView.frame = CGRect(x: 0, y: self.frame.width + 6, width: 16, height: 16)
    self.likesLabel.frame = CGRect(x: 24, y: self.frame.width + 6, width: self.frame.width, height: 16)
    self.commentImageView.frame = CGRect(x: 0, y: self.frame.width + 26, width: 16, height: 16)
    self.commentsLabel.frame = CGRect(x: 24, y: self.frame.width + 26, width: self.frame.width, height: 16)
  }
  
  override func prepareForReuse() {
    self.imageView.image = nil
  }
  
  
  // MARK: Configuring
  
  func configure(viewModel: InstagramMediaViewModel) {
    if !viewModel.imageURL.isEmpty {
      self.imageView.kf.setImage(with: URL(string: viewModel.imageURL))
    } else {
      self.imageView.image = UIImage(named: "placeholder")?.withRenderingMode(.alwaysOriginal)
    }
    
    self.commentsLabel.text = "\(viewModel.comments)"
    self.likesLabel.text = "\(viewModel.likes)"
  }
  
}
