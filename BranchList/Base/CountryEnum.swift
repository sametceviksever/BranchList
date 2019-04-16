//
//  Country.swift
//  BranchList
//
//  Created by Samet Çeviksever on 13.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public enum CountryEnum: String {
  static var countries: [CountryEnum] {
    return [.estonia, .latvia, .lithuania]
  }
  
  case estonia = "estonia"
  case latvia = "latvia"
  case lithuania = "lithuania"
  case test = "test"
  
  public var domain: String {
    switch self {
    case .estonia:
      return "www.swedbank.ee"
    case .latvia:
      return "ib.swedbank.lv"
    case .lithuania:
      return "ib.swedbank.lt"
    default:
      return ""
    }
  }
  
  public var urlString: String {
    return "https://" + domain + "/finder.json"
  }
  
  public var headerString: String {
    switch self {
    case .estonia:
      return "Estonia"
    case .latvia:
      return "Latvia"
    case .lithuania:
      return "Lithuania"
    default:
      return ""
    }
  }
}
