//
//  UILabel+.swift
//  Swift-Utilities
//
//  Created by Yariv on 1/27/15.
//  Copyright (c) 2015 Yariv. All rights reserved.
//

import UIKit

extension UILabel {
  convenience init(text: String) {
    self.init()
    self.text = text
    sizeToFit()
  }
}
