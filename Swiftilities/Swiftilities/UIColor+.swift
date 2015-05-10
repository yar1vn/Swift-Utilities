//
//  UIColor+.swift
//  Swift-Utilities
//
//  Created by Yariv on 1/28/15.
//  Copyright (c) 2015 Yariv. All rights reserved.
//

import UIKit

extension UIColor {
  class func darkGreenColor() -> Self {
    return self(red: 0, green: 0.7, blue: 0, alpha: 1)
  }
  
  class func outlineRedColor() -> Self {
    return self(red: 1, green: 0.2, blue:0, alpha: 1)
  }
}