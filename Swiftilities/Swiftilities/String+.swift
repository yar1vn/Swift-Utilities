//
//  String+.swift
//  Swift-Utilities
//
//  Created by Yariv on 1/27/15.
//  Copyright (c) 2015 Yariv. All rights reserved.
//

import Foundation

extension String {
  func isValidEmail() -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluateWithObject(self) ?? false
  }
  
  func trimmed() -> String {
    return self.stringByTrimmingCharactersInSet(.whitespaceCharacterSet())
  }
}
