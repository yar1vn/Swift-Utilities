//
//  CustomSegues.swift
//  Switiflities
//
//  Created by Yariv on 12/29/14.
//  Copyright (c) 2014 Yariv. All rights reserved.
//

import UIKit

// MARK:- Custom segues

enum CustomSegues: String {
  case Show = "Show"
  case Dismiss = "Dismiss"
  
  func performWithViewController(viewController: UIViewController, sender: AnyObject? = nil) {
    NSOperationQueue.mainQueue().addOperationWithBlock {
      viewController.performSegueWithIdentifier(self.rawValue, sender: sender ?? viewController)
    }
  }
}