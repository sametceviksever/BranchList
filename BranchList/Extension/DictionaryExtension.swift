//
//  DictionaryExtension.swift
//  BranchList
//
//  Created by Samet Çeviksever on 13.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public extension Array where Element == [String: Any] {
  var data: Data? {
    get {
      return try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
  }
}

public extension Dictionary where Key == String, Value == Any {
  var data: Data? {
    get {
      return try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
  }
}
