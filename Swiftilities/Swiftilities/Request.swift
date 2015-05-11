//
//  Request.swift
//  Swiftilities
//
//  Created by Yariv (Omega) on 12/9/14.
//  Copyright (c) 2014 Yariv. All rights reserved.
//

import UIKit

private let BaseURL = NSURL(string: "http://me.yariv/API/")
private let AuthorizationKey = "AuthorizationKey"

let ErrorDomain = "me.yariv.error"

typealias JSON = AnyObject
typealias JSONDictionary = [String:JSON]
typealias JSONArray = [JSON]

typealias RequestCompletionHandler = (json: JSON?, error: NSError?) -> Void
typealias Parameters = [String: Any]

enum Request {
  case Search(s: String)
  case GetRecord(id: String)
  case GetRecords
  
  // MARK:- Generate the GET request URL
  private var URL: NSURL! {
    let string: String
    switch self {
    case .Search(let s):      string = "Search/\(s)"
    case .GetRecord(let id):  string = "Record/\(id)"
    case .GetRecords:         string = "Record"
    }
    return NSURL(string: string)
  }
  
  private func URL(var #parameters: Parameters!) -> NSURL? {
    if let urlComponents = NSURLComponents(URL: URL, resolvingAgainstBaseURL: false) {
      parameters = parameters ?? Parameters() // Initialize if necessary
      
      switch self {
      case .GetRecord(let id):
        parameters["id"] = id
        fallthrough // Don't forget to add the key
      default:
        parameters["key"] = AuthorizationKey
      }
      
      var items = urlComponents.queryItems ?? [NSURLQueryItem]() // Initialize if necessary
      
      for (param, value) in parameters {
        items.append(NSURLQueryItem(name: param, value: "\(value)"))
      }
      urlComponents.queryItems = items
      return urlComponents.URLRelativeToURL(BaseURL)
    }
    return nil
  }
  
  // MARK:- Perform the appropriate GET request

  // Async
  
  func submitWithParameters(_ parameters: Parameters? = nil, _ completionHandler: RequestCompletionHandler) -> NSURLSessionTask? {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    
    return URL(parameters: parameters)?.GETAsync(
      
      failure: { (error, response) -> Void in
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        completionHandler(json: nil, error: error)
        
      }, success: { (data, response) -> Void in
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        var error: NSError?
        let json: JSON? = NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments, error: &error)
        completionHandler(json: json, error: error)
    })
  }
  
  func submit(completionHandler: RequestCompletionHandler) -> NSURLSessionTask? {
    return submitWithParameters(nil, completionHandler)
  }
  
  // Sync
  
  func submitSyncWithParameters(_ parameters: Parameters? = nil, _ completionHandler: RequestCompletionHandler) {
      
    let failure = { (error: NSError?, response: NSHTTPURLResponse?) -> Void in
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        completionHandler(json: nil, error: error)
        
      }
    let success = { (data: NSData, response: NSHTTPURLResponse) -> Void in
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        var error: NSError?
        let json: JSON? = NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments, error: &error)
        completionHandler(json: json, error: error)
    }
    
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    URL(parameters: parameters)?.GETSync(failure: failure, success: success)
  }
  
  func submitSync(completionHandler: RequestCompletionHandler) {
    submitSyncWithParameters(nil, completionHandler)
  }
}

// MARK:- Perform GET requests directly on the URL
extension NSURL {
  
  /// Send Synchronous Request
  func GETSync(#failure: (NSError?, NSHTTPURLResponse?) -> Void, success: (NSData, NSHTTPURLResponse) -> Void) {
    var response: NSURLResponse?
    var error: NSError?
    let request = NSMutableURLRequest(URL: self)
    let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    
    handleRequest(data, response: response, error: error, failure: failure, success: success)
  }
  
  /// Send Asynchronous Request
  func GETAsync(#failure: (NSError?, NSHTTPURLResponse?) -> Void, success: (NSData, NSHTTPURLResponse) -> Void)  -> NSURLSessionDataTask {
    let task = NSURLSession.sharedSession().dataTaskWithURL(self) { (data, response, var error) in
      self.handleRequest(data, response: response, error: error, failure: failure, success: success)
    }
    task.resume()
    return task
  }
  
  private func handleRequest(data: NSData?, response: NSURLResponse?, var error: NSError?,
    failure: (NSError?, NSHTTPURLResponse?) -> Void, success: (NSData, NSHTTPURLResponse) -> Void) {
    
    let httpResponse = response as? NSHTTPURLResponse
    
    switch (data, httpResponse, error) {
    case (.Some(let data), .Some(let response), .None) where response.statusCode == 200:
      success(data, response)
      
    default:
      // If no error found than return invalid response
      error = error ?? NSError(domain: ErrorDomain,
        code: httpResponse?.statusCode ?? 0,
        userInfo: [NSLocalizedDescriptionKey: "HTTP Response is different than 200"])
      failure(error, httpResponse)
    }
    
  }
}