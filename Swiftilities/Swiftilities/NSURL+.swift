//
//  NSURL+.swift
//  Swift-Utilities
//
//  Created by Yariv on 1/28/15.
//  Copyright (c) 2015 Yariv. All rights reserved.
//

import UIKit

extension NSURL {
  func canOpen() -> Bool {
    return UIApplication.sharedApplication().canOpenURL(self)
  }
  
  func launchInSafari() {
    UIApplication.sharedApplication().openURL(self)
  }
}