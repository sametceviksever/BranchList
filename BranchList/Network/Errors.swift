//
//  Errors.swift
//  BranchList
//
//  Created by Samet Çeviksever on 13.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
  case urlError
  case notfound
  case `default`
  case custom(Error)
  case http(Int)
  
  public var localizedDescription: String {
    switch self {
    case .urlError:
      return "URL is wrong"
    case .notfound:
      return "Not Found"
    case .custom(let err):
      return err.localizedDescription
    case .http(let errorCode):
      return "\(errorCode)"
    case .default:
      return "Somethings wrong"
    }
  }
}
