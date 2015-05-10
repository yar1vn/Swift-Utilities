//
//  Utilities.swift
//  Swift-Utilities
//
//  Created by Yariv on 1/28/15.
//  Copyright (c) 2015 Yariv. All rights reserved.
//

import UIKit

func delay(delay:Double, closure:()->()) {
  dispatch_after(
    dispatch_time(
      DISPATCH_TIME_NOW,
      Int64(delay * Double(NSEC_PER_SEC))
    ),
    dispatch_get_main_queue(), closure)
}

enum SystemInfo: String, Printable {
  case Device = "device"
  case OSVersion = "os_version"
  case AppVersion = "app_version"
  case AppBuild = "app_bulid"
  
  var description: String {
    switch self {
    case .Device:     return UIDevice.currentDevice().model
    case .OSVersion:  return UIDevice.currentDevice().systemVersion
    case .AppVersion: return valueFromInfoDictionary("CFBundleShortVersionString")!
    case .AppBuild:   return valueFromInfoDictionary("CFBundleVersion")!
    }
  }
  
  static var versionSummary: String {
    return "\(AppVersion.description) (\(AppBuild.description))"
  }
  
  static var dictionary: [String: String] {
    var dict: [String:String] = [:]
    for info in [OSVersion, Device, AppVersion, AppBuild] {
      dict[info.rawValue] = info.description
    }
    return dict
  }
  
  static func stringWithSystemInfo(var tokenizedString string: String) -> String {
    for (key, value) in dictionary {
      string = string.stringByReplacingOccurrencesOfString("{\(key)}", withString: value)
    }
    return string
  }
  
  private func valueFromInfoDictionary(key: String) -> String? {
    return NSBundle.mainBundle().infoDictionary?[key] as? String
  }
}

let isPhone = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone
let isPad = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad