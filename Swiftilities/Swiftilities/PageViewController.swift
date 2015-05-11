//
//  PageViewController.swift
//  Swiftilities
//
//  Created by Yariv on 12/25/14.
//  Copyright (c) 2014 Yariv. All rights reserved.
//

import UIKit

typealias Record = AnyObject
typealias MyViewController = UIViewController

class PageViewController: UIPageViewController {
  var records: [Record]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    dataSource = self
    
    setViewControllers([viewControllerWithIndex(0)], direction: .Forward, animated: false, completion: nil)
  }
  
  func countAndSetupPageControl() -> Int {
    pageControl?.hidesForSinglePage = true
    pageControl?.pageIndicatorTintColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
    pageControl?.currentPageIndicatorTintColor = view.tintColor
    
    if let records = records {
      if pageControl?.sizeForNumberOfPages(records.count).width > self.view.bounds.width {
        pageControl?.removeFromSuperview()
      }
    }
    return records?.count ?? 0
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    adjustInsets(viewController)
  }
  
  override func preferredContentSizeDidChangeForChildContentContainer(container: UIContentContainer) {
    // Avoid shrinking the popover
    if preferredContentSize.height < container.preferredContentSize.height {
      preferredContentSize = container.preferredContentSize
    }
  }
  
  func adjustInsets(viewController: UIViewController?) {
    if let vc = viewController as? UITableViewController {
      vc.tableView.contentInset.top = layoutGuidesInsets.top
      vc.tableView.contentOffset.y = -layoutGuidesInsets.top
      vc.tableView.scrollIndicatorInsets.top = layoutGuidesInsets.top
    }
  }
}

// MARK:- UIPageViewControllerDataSource

extension PageViewController: UIPageViewControllerDataSource {
  
  func viewControllerWithIndex(var index: Int) -> UIViewController! {
    let myViewController = storyboard?.instantiateViewControllerWithIdentifier("MyViewController") as! MyViewController
    
    if let count = records?.endIndex {
      if count == 1 && index != 0 { return nil }
      if index < 0 { index += count }
      index %= count
    }
    
    myViewController.view.tag = index
    // myViewController.record = records?[index] // TODO: Implement @record in MyViewController
    
    return myViewController
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    let index = viewController.view?.tag ?? 0
    return viewControllerWithIndex(index + 1)
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    let index = viewController.view?.tag ?? 0
    return viewControllerWithIndex(index - 1)
  }
  
  func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
    return countAndSetupPageControl()
  }
  
  func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
    return viewController?.view.tag ?? 0
  }
}