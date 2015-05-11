//
//  JSON Parsing.swift
//  Switiflities
//
//  Created by Yariv on 12/16/14.
//  Copyright (c) 2014 Yariv. All rights reserved.
//

import Foundation

// MARK:- Custom Operator definitions

prefix operator <!> {}
postfix operator |>> {}
infix operator <| { associativity left precedence 150 }
infix operator <<| { associativity left precedence 150 }
infix operator <<|? { associativity left precedence 150 }
infix operator <^> { associativity left }
infix operator <*> { associativity left }

// MARK:- Extract data

/// Extract from JSONDictionary
func <| <T>(json: JSONDictionary, key: String) -> T? {
  return json[key] as? T
}

/// Extract from JSON if possible
func <| <T>(json: JSON, key: String) -> T? {
  if let json = json as? JSONDictionary {
    return json <| key
  }
  return nil
}

/// Extract from JSON into an Array or Parsable objects
func <<| <T: JSONParsable>(json: JSON, key: String) -> [T]? {
  return (json <| key)|>>
}

/// Extract from JSON into an Array or Parsable objects
func <<|? <T: JSONParsable>(json: JSON, key: String) -> [T]?? {
  return .Some((json <| key)|>>)
}


// MARK:- Parse JSON

/// Unwrap Array objects, ignore nil values
prefix func <!> <T>(array: [T?]) -> [T] {
  return array.filter{ $0 != nil }.map{ $0! }
}

/// Parse JSON into a Parsable object
postfix func |>> <T: JSONParsable>(j: JSON?) -> T? {
  if let j: JSON = j {
    return T.parse(j)
  }
  return nil
}

/// Parse JSON into Array if possible
postfix func |>> <T: JSONParsable>(j: JSON?) -> [T]? {
  if let j = j as? JSONArray {
    return <!>j.map { T.parse($0) }
  }
  return nil
}

/// Implement to allow parsing operators
protocol JSONParsable {
  static func parse(j: JSON) -> Self?
}

// MARK:- Function currying

/// Functor's fmap
func <^><A, B>(f: A -> B, a: A?) -> B? {
  if let x = a {
    return f(x)
  } else {
    return .None
  }
}

/// Applicative's apply
func <*><A, B>(f: (A -> B)?, a: A?) -> B? {
  if let x = a {
    if let fx = f {
      return fx(x)
    }
  }
  return .None
}
