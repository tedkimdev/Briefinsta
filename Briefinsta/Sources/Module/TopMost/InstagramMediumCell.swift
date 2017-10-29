//
//  InstagramMediumCell.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 28..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

final class InstagramMediumCell: UICollectionViewCell {
  
  // MARK: Constants
  
  fileprivate struct Metric {
    static let likeImageViewTop: CGFloat = 6.0
    static let likeImageViewWidthHeight: CGFloat = 16.0
    
    static let likeLabelLeft: CGFloat = 4.0
    static let likeLabelHeight: CGFloat = 16.0
    
    static let commentImageViewTop: CGFloat = 6.0
    static let commentImageViewWidthHeight: CGFloat = Font.textLabel.lineHeight
    
    static let commentLabelLeft: CGFloat = 4.0
    static let commentLabelHeight: CGFloat = Font.textLabel.lineHeight
  }
  
  fileprivate struct Font {
    static let textLabel = UIFont.systemFont(ofSize: 15)
  }
  
  
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
    image.tintColor = .bi_charcoal
    image.image = UIImage(named: "icon-comment")?.withRenderingMode(.alwaysTemplate)
    return image
  }()
  
  let likeLabel: UILabel = {
    let label = UILabel()
    label.font = Font.textLabel
    return label
  }()
  
  let commentLabel: UILabel = {
    let label = UILabel()
    label.font = Font.textLabel
    label.textColor = .bi_slate
    return label
  }()
  
  fileprivate func setupUI() {
    self.addSubview(self.imageView)
    self.addSubview(self.likeImageView)
    self.addSubview(self.likeLabel)
    self.addSubview(self.commentImageView)
    self.addSubview(self.commentLabel)
    
    self.imageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.width)
    
    self.likeImageView.frame = CGRect(x: 0,
                                      y: self.frame.width + Metric.likeImageViewTop,
                                      width: Metric.likeImageViewWidthHeight,
                                      height: Metric.likeImageViewWidthHeight)
    
    self.likeLabel.frame = CGRect(x: self.likeImageView.right + Metric.likeLabelLeft,
                                   y: self.likeImageView.top,
                                   width: self.frame.width - self.likeImageView.right - Metric.likeLabelLeft * 2,
                                   height: Metric.likeLabelHeight)
    
    self.commentImageView.frame = CGRect(x: 0,
                                         y: self.likeImageView.bottom + Metric.commentImageViewTop,
                                         width: Metric.commentImageViewWidthHeight,
                                         height: Metric.commentImageViewWidthHeight)
    
    self.commentLabel.frame = CGRect(x: self.commentImageView.right + Metric.commentLabelLeft,
                                      y: self.commentImageView.top,
                                      width: self.frame.width - self.commentImageView.right - Metric.commentLabelLeft * 2,
                                      height: Metric.commentImageViewWidthHeight)
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
    
    self.commentLabel.text = "\(viewModel.comments)"
    self.likeLabel.text = "\(viewModel.likes)"
  }
  
}
