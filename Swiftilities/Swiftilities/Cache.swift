//
//  Cache.swift
//  Switiflities
//
//  Created by Yariv on 1/6/15.
//  Copyright (c) 2015 Yariv. All rights reserved.
//

import Foundation

struct Cache {
  var maxSize = 10
  var count: Int     { return _cache.count }
  var first: String? { return _cache.first }
  var last:  String? { return _cache.last }
  
  private var _cache = [String]()
  
  init(objects: [String]? = nil) {
    _cache = objects ?? []
  }
  
  subscript(index: Int) -> String {
    get { return _cache[index] }
    set { _cache[index] = newValue }
  }
  
  mutating func append(object: String) -> String {
    // prevent duplicates
    if let index = find(_cache, object) {
      _cache.removeAtIndex(index)
    }
    
    _cache.insert(object, atIndex: 0)
    
    // enforce max size
    if _cache.count > maxSize {
      _cache.removeLast()
    }
    return object
  }
  
  mutating func removeAll() {
    _cache.removeAll()
  }
}

extension Cache: Serializable {
  func toJSON() -> JSON {
    return _cache
  }
  
  static func fromJSON(json: JSON) -> Cache? {
    if let objects = json as? [String] {
      return Cache(objects: objects)
    }
    return nil
  }
}