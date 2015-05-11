//
//  DateGenerator.swift
//  Swiftilities
//
//  Created by Yariv on 12/5/14.
//  Copyright (c) 2014 Yariv. All rights reserved.
//

import Foundation

typealias DateGenerators = [DateGenerator]

enum DateGenerator: Printable {
  case Day(Int), Month(Int)
  
  var description: String {
    switch self {
    case .Day(let day) where day == 1:
      return "Past 24 hours"
    case .Day(let day) where day == 7:
      return "Past Week"
    case .Day(let days) where days <= 31:
      return "Past \(days) days"
    case .Month(let months) where months == 1:
      return "Past Month"
    case .Month(let months) where months == 12:
      return "Past year"
    case .Month(let months):
      return "Past \(months) months"
    default:
      return "Invalid Date"
    }
  }
  
  func isEqual(date: DateGenerator) -> Bool {
    switch (self, date) {
    case (.Day(let a), .Day(let b)) where a == b:
      return true
    case (.Month(let a), .Month(let b)) where a == b:
      return true
    default:
      return false
    }
  }
  
  var date: NSDate {
    let components = NSDateComponents()
    
    switch self {
    case .Day(let days):
      components.day = -days
    case .Month(let months):
      components.month = -months
    }
    if let date = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: NSDate(), options: nil) {
      return date
    }
    let days = -3, hours = 24, minutes = 60, seconds = 60
    return NSDate(timeIntervalSinceNow: NSTimeInterval(-days * hours * minutes * seconds)) // Return a default in case of an error
  }
  
  private struct Static {
    static let formatter = NSDateFormatter()
  }
  
  func toString(format: String? = nil) -> String {
    Static.formatter.dateFormat = format
    return Static.formatter.stringFromDate(date)
  }
}

// MARK:- Serializable

extension DateGenerator: Serializable {
  private struct C {
    static let type = "Type", value = "Value" // keys
    static let day = "Day", month = "Month" // values
  }
  
  func toJSON() -> JSON {
    switch self {
    case .Day(let days):
      return [C.type: C.day,
              C.value: days]
    case .Month(let months):
      return [C.type: C.month,
              C.value: months]
    }
  }
  
  static func fromJSON(json: JSON) -> DateGenerator? {
    if let type = json[C.type] as? String {
      if let value = json[C.value] as? Int {
        switch type {
        case C.day:   return .Day(value)
        case C.month: return .Month(value)
        default: ()
        }
      }
    }
    return nil
  }
}

// MARK:-

extension DateGenerator {
  static let defaultCases = [DateGenerator.Day(1), .Day(3), .Day(7), .Month(1), .Month(3), .Month(6)]
}