//
//  BankLocation.swift
//  BranchList
//
//  Created by Samet Çeviksever on 14.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

public enum BranchType: Int {
  case branch = 0
  case ATM = 1
  case BNA = 2
  
  init(_ id: Int) {
    guard let type = BranchType(rawValue: id) else {
      self = .branch
      return
    }
    self = type
  }
  
  var name: String {
    switch self {
    case .branch:
      return "Branch"
    case .ATM:
      return "ATM"
    case .BNA:
      return "BNA"
    }
  }
  
  var alias: String {
    switch self {
    case .branch:
      return "BR"
    case .ATM:
      return "A"
    case .BNA:
      return "R"
    }
  }
  
  var backgroundColor: UIColor {
    switch self {
    case .branch:
      return UIColor(red: 93/255, green: 178/255, blue: 239/255, alpha: 1)
    case .ATM:
      return UIColor(red: 236/255, green: 189/255, blue: 93/255, alpha: 1)
    case .BNA:
      return UIColor(red: 149/255, green: 201/255, blue: 103/255, alpha: 1)
    }
  }
}

public struct Branch {
  public struct Grouped {
    let title: String?
    var infos: [(String, String)]
    
    init?(title: String?, infos: [(String, String?)]) {
      self.title = title
      self.infos = []
      for (key, value) in infos {
        if let value = value {
          self.infos.append((key, value))
        }
      }
      
      if self.infos.count == 0 {
        return nil
      }
    }
  }
  
  let latitude: Double
  let longitude: Double
  let type: BranchType
  let name: String
  let address: String
  let region: String
  let availability: String?
  let info: String?
  let noCash: Bool?
  let hasCoinStation: Bool?
  
  public init(_ dict: [String: Any]){
    latitude = dict["lat"] as? Double ?? 0
    longitude = dict["lon"] as? Double ?? 0
    type = BranchType(dict["t"] as? Int ?? 0)
    name = dict["n"] as? String ?? ""
    address = dict["a"] as? String ?? ""
    region = dict["r"] as? String ?? "Unknown Region"
    availability = dict[""] as? String
    info = dict["i"] as? String
    noCash = dict["ncash"] as? Bool
    hasCoinStation = dict["cs"] as? Bool
  }
  
  public func groupedInfo() -> [Grouped] {
    let info = Grouped(title: nil, infos: [("TYPE", type.name), ("NAME", name), ("ADDRESS", address), ("REGION", region)])
    let extraInfo = Grouped(title: nil, infos: [("AVAILABILITY", availability), ("INFO", self.info)])
    
    var group: [Grouped] = []
    if let info = info {
      group.append(info)
    }
    if let extraInfo = extraInfo {
      group.append(extraInfo)
    }
    
    return group
  }
}

