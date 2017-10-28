//
//  AddUserAccountCell.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 26..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

protocol AddUserAccountCellType {
  func configure(text: String)
}

final class AddUserAccountCell: UITableViewCell {
  
  // MARK: Constants
  
  fileprivate struct Metric {
    static let usernameFieldLeftRight: CGFloat = 10.0
  }
  
  fileprivate struct Font {
    static let usernameField = UIFont.systemFont(ofSize: 15)
  }
  
  
  // MARK: Properties
  
  var textDidChange: ((String?) -> Void)?
  
  
  // MARK: UI
  
  let usernameField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Username"
    return textField
  }()
  
  
  // MARK: Initializing
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.usernameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

    self.selectionStyle = .none
    self.addSubview(self.usernameField)
    self.usernameField.snp.makeConstraints { make in
      make.left.equalTo(self).offset(Metric.usernameFieldLeftRight)
      make.right.equalTo(self).offset(-Metric.usernameFieldLeftRight)
      make.centerY.equalTo(self)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: Configuring
  
  func configure(text: String) {
  }
  
//  override public func setHighlighted(_ highlighted: Bool, animated: Bool) {
//    super.setHighlighted(highlighted, animated: animated)
//
//    if highlighted {
//      self.backgroundColor = UIColor.bi_settingCellBackground
//    } else {
//      self.backgroundColor = .white
//    }
//  }
  
  @objc fileprivate func textFieldDidChange(_ textField: UITextField) {
    self.textDidChange?(textField.text)
  }
  
}
