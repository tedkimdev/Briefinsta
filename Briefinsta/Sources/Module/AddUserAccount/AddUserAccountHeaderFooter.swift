//
//  AddUserAccountHeaderFooter.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 26..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

protocol AddUserAccountHeaderFooterType {
  func configure(text: String)
}


final class AddUserAccountHeaderFooter: UITableViewCell, AddUserAccountHeaderFooterType {
  
  // MARK: Constants
  
  fileprivate struct Metric {
    static let titleLabelLeftRight: CGFloat = 8.0
  }
  
  fileprivate struct Font {
    static let titleLabel = UIFont.systemFont(ofSize: 12)
  }
  
  
  // MARK: Properties
  
  
  // MARK: UI
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = Font.titleLabel
    label.textColor = .bi_charcoal
    return label
  }()
  
  
  // MARK: Initializing
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.backgroundColor = .bi_headerBackground
    self.addSubview(self.titleLabel)
    self.titleLabel.snp.makeConstraints { make in
      make.left.equalTo(self).offset(Metric.titleLabelLeftRight)
      make.right.equalTo(self).offset(-Metric.titleLabelLeftRight)
      make.centerY.equalTo(self)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: Configuring
  
  func configure(text: String) {
    self.titleLabel.text = text
  }
  
}
