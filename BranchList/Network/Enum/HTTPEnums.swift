//
//  HTTPEnums.swift
//  BranchList
//
//  Created by Samet Çeviksever on 13.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public enum ContentType:String{
  case json = "application/json; charset=utf-8"
  case urlencoded = "application/x-www-form-urlencoded"
  case none = ""
}

public enum MethodType: String {
  case post = "POST"
  case get = "GET"
  case put = "PUT"
}
