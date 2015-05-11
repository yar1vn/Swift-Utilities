//
//  UITableViewCell+.swift
//  Swiftilities
//
//  Created by Yariv on 1/28/15.
//  Copyright (c) 2015 Yariv. All rights reserved.
//

import UIKit

extension UITableViewCell {
  func flash(delay delay_: Double) {
    setHighlighted(true, animated: true)
    delay(delay_) {
      self.setHighlighted(false, animated: true)
    }
  }
}