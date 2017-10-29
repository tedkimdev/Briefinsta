//
//  UIColor+Briefinsta.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 26..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

import UIKit

extension UIColor {
  class var bi_sea: UIColor { return 0x3BA3BF.color }
  class var bi_settingCellBackground: UIColor { return 0xEFEFEF.color }
  class var bi_headerBackground: UIColor {
    return UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 0.9)
  }
  class var bi_lineColor: UIColor { return 0xE1E4E8.color }
  class var bi_textColor: UIColor { return 0x5C6774.color }
  class var bi_charcoal: UIColor { return 0x333333.color }
  class var bi_slate: UIColor { return 0x9DA3A5.color }
}


extension Int {
  var color: UIColor {
    return UIColor(
      red: (CGFloat((self >> 16) % 0x000100)) / 255,
      green: (CGFloat((self >> 8) % 0x000100)) / 255,
      blue: (CGFloat(self % 0x000100)) / 255,
      alpha: 1.0
    )
  }
}
