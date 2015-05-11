//
//  Distance.swift
//  Switiflities
//
//  Created by Yariv on 1/13/15.
//  Copyright (c) 2015 Yariv. All rights reserved.
//

import Foundation

enum Distance: Printable {
  case Miles(Double)
  case Feet(Int)
  
  var miles: Double {
    switch self {
    case .Miles(let miles):
      return miles
    case .Feet(let feet):
      let feetInMile = 5_280.0
      return Double(feet) / feetInMile
    }
  }
  
  var description: String {
    switch self {
    case .Miles(let miles) where miles == 1:
      return "1 Mile"
    case .Miles(let miles) where miles > 0:
      return "\(miles) Miles"
    case .Feet(let feet) where feet == 1:
      return "1 Foot"
    case .Feet(let feet) where feet > 0:
      return "\(feet) Feet"
    default:
      return "None"
    }
  }
}

extension Distance: Equatable {}
func ==(lhs: Distance, rhs: Distance) -> Bool {
  switch (lhs, rhs) {
  case (.Miles(let l), .Miles(let r)) where l == r:
    return true
  case (.Feet(let l), .Feet(let r)) where l == r:
    return true
  default:
    return false
  }
}

extension Distance: FloatLiteralConvertible {
  init(floatLiteral value: FloatLiteralType) {
    self = .Miles(value)
  }
}

extension Distance: IntegerLiteralConvertible {
  init(integerLiteral value: IntegerLiteralType) {
    self = .Feet(value)
  }
}

extension Distance {
  static let defaultDistances = [Distance.Miles(2), .Miles(1), .Miles(0.5), .Miles(0.2), .Feet(500)]
}