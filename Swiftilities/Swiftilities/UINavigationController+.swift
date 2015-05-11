//
//  UINavigationController+.swift
//  Swiftilities
//
//  Created by Yariv (Omega) on 12/6/14.
//  Copyright (c) 2014 Yariv. All rights reserved.
//

import UIKit

extension UINavigationController {
  
  // Remove the border ImageView from the NavigationBar background
  func hideBottomBorder() {
    navigationBar.subviews.first?.subviews?.first?.removeFromSuperview()

    /*
    // This crashes on the device
    if let view = navigationBar.subviews.filter({ NSStringFromClass($0.dynamicType) == "_UINavigationBarBackground" }).first as? UIView {
      if let imageView = view.subviews.filter({ $0 is UIImageView }).first as? UIImageView {
        imageView.removeFromSuperview()
      }
    }
    */
  }
  
  override var rootViewController: UIViewController? {
    return viewControllers.first as? UIViewController
  }
}