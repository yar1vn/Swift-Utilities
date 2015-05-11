//
//  WebViewController.swift
//  Swiftilities
//
//  Created by Yariv on 1/29/15.
//  Copyright (c) 2015 Yariv. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
  @IBOutlet weak var webView: UIWebView?
  
  private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
  
  var url: NSURL? {
    didSet {
      loadURL()
    }
  }
  
  func loadURL() {
    if let url = url {
      webView?.loadRequest(NSURLRequest(URL: url))
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    webView?.scalesPageToFit = true
    
    if webView?.request == nil {
      loadURL()
    }
  }
}

// MARK:- UIWebViewDelegate

extension WebViewController: UIWebViewDelegate {
  
  func webViewDidStartLoad(webView: UIWebView) {
    navigationItem.titleView = activityIndicator
    activityIndicator.startAnimating()
  }
  
  func webViewDidFinishLoad(webView: UIWebView) {
    navigationItem.titleView = nil
  }
  
  func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
    navigationItem.titleView = nil
    presentAlertController(title: "Cannot Load Page", message: "Please try again")
  }
  
  func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    switch navigationType {
    case .Other:
      return true
    case .LinkClicked:
      if let url = request.mainDocumentURL {
        if url.canOpen() {
          url.launchInSafari()
        }
      }
      fallthrough
    default:
      return false
    }
  }
}