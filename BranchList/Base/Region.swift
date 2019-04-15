//
//  Region.swift
//  BranchList
//
//  Created by Samet Çeviksever on 14.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public struct Region {
  
  public let name: String
  public var branches: [Branch]
  
  init(name: String) {
    self.name = name
    branches = []
  }
}
