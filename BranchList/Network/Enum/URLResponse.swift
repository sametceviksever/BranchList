//
//  URLResponse.swift
//  BranchList
//
//  Created by Samet Çeviksever on 13.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public enum URLResponseType<T> {
  case success(T)
  case error(Error)
  
  var value: T? {
    switch self {
    case .success(let reponse):
      return reponse
    default:
      return nil
    }
  }
  
  var error: Error? {
    switch self {
    case .error(let error):
      return error
    default:
      return nil
    }
  }
}
