//
//  DataExtension.swift
//  BranchList
//
//  Created by Samet Çeviksever on 13.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public extension Data {
  
  func jsonObject <T>() -> T? {
    let json = try? JSONSerialization.jsonObject(with: self, options: .allowFragments) as? T
    return json
  }
}
