//
//  UIAlertController+.swift
//  Swift-Utilities
//
//  Created by Yariv on 1/15/15.
//  Copyright (c) 2015 Yariv. All rights reserved.
//

import UIKit

extension UIAlertController {
  convenience init(title: String? = nil, message: String? = nil) {
    self.init(title: title, message: message, preferredStyle: .Alert)
    addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
  }
}
