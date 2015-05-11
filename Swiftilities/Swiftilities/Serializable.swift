//
//  Serializable.swift
//  Switiflities
//
//  Created by Yariv on 12/18/14.
//  Copyright (c) 2014 Yariv. All rights reserved.
//

import Foundation

protocol Serializable {
  func toJSON() -> JSON
  static func fromJSON(json: JSON) -> Self?
}

extension NSUserDefaults {
  func setObject<T: Serializable>(value: T, forKey key: String) {
    setObject(value.toJSON(), forKey: key)
  }
  
  func setObject<T: Serializable>(value: [T], forKey key: String) {
    setObject(value.map { $0.toJSON() }, forKey: key)
  }
  
  func objectForKey<T: Serializable>(key: String) -> T? {
    if let json: JSON = objectForKey(key) {
      return T.fromJSON(json)
    }
    return nil
  }
  
  func objectForKey<T: Serializable>(key: String) -> [T]? {
    if let json = objectForKey(key) as? [JSON] {
      return <!>json.map{ T.fromJSON($0) }
    }
    return nil
  }
}
