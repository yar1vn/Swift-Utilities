//
//  UIView+.swift
//  Swift-Utilities
//
//  Created by Yariv on 1/27/15.
//  Copyright (c) 2015 Yariv. All rights reserved.
//

import UIKit

extension UIView {
  var containingCell: UITableViewCell? {
    
    if superview != nil {
      if let cell = superview as? UITableViewCell {
        return cell
      }
      return superview?.containingCell
    }
    return nil
  }
}