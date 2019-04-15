//
//  BranchRequest.swift
//  BranchList
//
//  Created by Samet Çeviksever on 13.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

struct BankLocationRequest: Request {
  private var country: CountryEnum
  var methodType: MethodType {return .get}
  var url: String {return country.urlString}
  var handler: NetworkResponseBlock<[[String: Any]]>?
  
  init(country: CountryEnum) {
    self.country = country
  }
}
