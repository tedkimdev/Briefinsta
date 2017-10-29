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
    image.image = UIImage(named: "placeHolder")
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
    self.addSubview(self.likesLabel)
    self.addSubview(self.commentsLabel)
    self.imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
    self.likesLabel.frame = CGRect(x: 0, y: frame.width + 6, width: frame.width, height: 16)
    self.commentsLabel.frame = CGRect(x: 0, y: frame.width + 25, width: frame.width, height: 16)
  }
  
  override func prepareForReuse() {
    self.imageView.image = nil
  }
  
  
  // MARK: Configuring
  
  func configure(viewModel: InstagramMediaViewModel) {
    self.imageView.kf.setImage(with: URL(string: viewModel.imageURL))
    self.commentsLabel.text = "Comments \(viewModel.comments)"
    self.likesLabel.text = "Likes \(viewModel.likes)"
  }
  
}
