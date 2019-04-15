//
//  Reusable.swift
//  BranchList
//
//  Created by Samet Çeviksever on 15.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public protocol Reusable: class {
  static var reuseIdentifier: String {get}
}

public extension Reusable {
  static var reuseIdentifier: String {return String(describing: self)}
}
