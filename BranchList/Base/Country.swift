//
//  Country.swift
//  BranchList
//
//  Created by Samet Çeviksever on 14.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public struct Country {
  
  public let type: CountryEnum
  public var regions: [Region]
  
  init(type: CountryEnum) {
    self.type = type
    regions = []
  }
  
  static func convert(dictList: [[String: Any]], to country: CountryEnum) -> Country{
    var countryModel = Country(type: country)
    var regions: [Region] = []
    for dict in dictList {
      let branch = Branch(dict)
      if let index = regions.firstIndex(where: {$0.name == branch.region}) {
        regions[index].branches.append(branch)
      } else {
        var region = Region(name: branch.region)
        region.branches = [branch]
        regions.append(region)
      }
    }
    regions.sort(by: {$0.name < $1.name})
    
    countryModel.regions = regions
    return countryModel
  }
  
}
