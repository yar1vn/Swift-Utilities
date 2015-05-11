//
//  UIActivityIndicatorView+.swift
//  Swiftilities
//
//  Created by Yariv on 2/12/15.
//  Copyright (c) 2015 Yariv. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
  convenience init!(activityIndicatorStyle style: UIActivityIndicatorViewStyle, centeredInSuperview aSuperview: UIView) {
    self.init(activityIndicatorStyle: style)
    
    setTranslatesAutoresizingMaskIntoConstraints(false)
    
    let centerX = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.CenterX, relatedBy: .Equal, toItem: aSuperview, attribute: .CenterX, multiplier: 1, constant: 0)
    let centerY = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.CenterY, relatedBy: .Equal, toItem: aSuperview, attribute: .CenterY, multiplier: 1, constant: 0)
    
    aSuperview.addSubview(self)
    aSuperview.addConstraints([centerX, centerY])
  }
}
