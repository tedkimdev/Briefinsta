//
//  SettingViewTableCell.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 25..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

protocol SettingViewTableCellType {
  func configure(text: String, detail: String?)
}


final class SettingViewTableCell: UITableViewCell, SettingViewTableCellType {
  
  // MARK: Constants
  
  fileprivate struct Metric {
    static let settingLabelLeftRight: CGFloat = 20.0
    
    static let detailLabelLeftRight: CGFloat = 20.0
    
    static let settingImageViewRight: CGFloat = 20.0
    static let settingImageWidthHeight: CGFloat = 14.0
    
    static let bottomLineLeftRight: CGFloat = 20.0
    static let bottomLineHeight: CGFloat = 1 / UIScreen.main.scale
  }
  
  fileprivate struct Font {
    static let settingLabel = UIFont.systemFont(ofSize: 15)
    static let detailLabel = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
  }
  
  
  // MARK: Properties
  
  
  // MARK: UI
  
  let settingLabel: UILabel = {
    let label = UILabel()
    label.font = Font.settingLabel
    label.textColor = .bi_textColor
    return label
  }()
  
  let detailLabel: UILabel = {
    let label = UILabel()
    label.isHidden = true
    label.font = Font.settingLabel
    label.textColor = .lightGray
    return label
  }()
  
  let settingImageView: UIImageView = {
    return UIImageView(image: UIImage(named: "icon-enter"))
  }()
  
  
  // MARK: Initializing
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.selectionStyle = .none
    
    self.addSubview(self.settingImageView)
    self.addSubview(self.detailLabel)
    self.addSubview(self.settingLabel)
    
    self.settingImageView.snp.makeConstraints { make in
      make.right.equalToSuperview().offset(-Metric.settingImageViewRight)
      make.width.height.equalTo(Metric.settingImageWidthHeight)
      make.centerY.equalToSuperview()
    }
    self.detailLabel.snp.makeConstraints { make in
      make.right.equalTo(self.settingImageView.snp.left).offset(-Metric.detailLabelLeftRight)
      make.centerY.equalToSuperview()
    }
    self.settingLabel.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(Metric.settingLabelLeftRight)
//      make.right.equalTo(self.detailLabel.snp.left).offset(-Metric.settingLabelLeftRight)
      make.centerY.equalToSuperview()
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: Configuring
  
  func configure(text: String, detail: String? = nil) {
    self.settingLabel.text = text
    if let detail = detail {
      self.detailLabel.text = detail
      self.detailLabel.isHidden = false
    }
  }
  
  override public func setHighlighted(_ highlighted: Bool, animated: Bool) {
    super.setHighlighted(highlighted, animated: animated)
    
    if highlighted {
      self.backgroundColor = .bi_settingCellBackground
    } else {
      self.backgroundColor = .white
    }
  }
  
}
