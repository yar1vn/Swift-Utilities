//
//  UIViewController+.swift
//  Swiftilities
//
//  Created by Yariv on 12/4/14.
//  Copyright (c) 2014 Yariv. All rights reserved.
//

import UIKit

extension UIViewController {
  
  // MARK:- Layout Guides
  
  var layoutGuidesInsets: UIEdgeInsets {
    return UIEdgeInsets(top: topLayoutGuide.length, left: 0, bottom: bottomLayoutGuide.length, right: 0)
  }
  
  // MARK:- UINavigationController
  
  var rootViewControllerOrSelf: UIViewController {
    return rootViewController ?? self
  }
  
  var rootViewController: UIViewController? {
    if let navigationController = self as? UINavigationController {
      return navigationController.rootViewController
    }
    return nil
  }
  
  // MARK:- Launch Safari
  
  func presentAlertForURL(#string: String) {
    presentAlertForURL(url: NSURL(string: string))
  }
  
  func presentAlertForURL(#url: NSURL?) {
    if let alert = alertForURL(url: url) {
      presentViewController(alert, animated: true, completion: nil)
    }
  }
  
  func alertForURL(#url: NSURL?) -> UIAlertController? {
    if let url = url {
      if url.canOpen() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        alert.addAction(UIAlertAction(title: "Open in Safari", style: .Default) { action in
          url.launchInSafari()
          })
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        return alert
      }
    }
    return nil
  }
  
  // MARK:- Done button for Compact size class
  
  // Call this method for every adapted view controller
  //  Override on the PresentedViewController to relocate the button
  func createDismissButton() {
    createDismissButton(onLeftBarButton: true)
  }
  
  func createDismissButton(onLeftBarButton isOnLeft: Bool, type: UIBarButtonSystemItem = .Done) {
    let button = UIBarButtonItem(barButtonSystemItem: type, target: self, action: "dismiss")
    
    if isOnLeft {
      navigationItem.leftBarButtonItem = button
    } else {
      navigationItem.rightBarButtonItem = button
    }
  }
  
  func presentAlertController(title: String? = nil, message: String? = nil) {
    presentViewController(UIAlertController(title: title, message: message), animated: true, completion: nil)
  }
  
  // MARK:- Dismissing View Controllers
  
  func dismiss() {
    presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
  }
  
  // Dismiss currently presented view controller, if exists, then present the new one
  func dissmissAndPresentViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
    if let presentedViewController = presentedViewController {
      dismissViewControllerAnimated(flag) {
        self.presentViewController(viewControllerToPresent, animated: flag, completion: completion)
      }
    } else {
      presentViewController(viewControllerToPresent, animated: flag, completion: completion)
    }
  }
}