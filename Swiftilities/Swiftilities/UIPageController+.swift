//
//  UIPageController+.swift
//  Swift-Utilities
//
//  Created by Yariv on 12/26/14.
//  Copyright (c) 2014 Yariv. All rights reserved.
//

import UIKit

extension UIPageViewController {
  var pageControl: UIPageControl! {
    return view.subviews.filter{ $0 is UIPageControl }.first as? UIPageControl
  }
  
  var viewController: UIViewController? {
    return viewControllers.first as? UIViewController
  }
}