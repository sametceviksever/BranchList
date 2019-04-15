//
//  BranchListModelTest.swift
//  BranchListFileTests
//
//  Created by Samet Çeviksever on 14.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import XCTest
@testable import BranchList

class BranchListModelTest: XCTestCase {
  
  func testBranch() {
    let data: [String: Any] = [ "t": 0,
      "n": "KAUBAMAJAKA",
      "a": "PAPINIIDU 8, 80010 PÄRNU",
      "av": "E-R 10.00-18.00; L 10.00-15.00",
      "r": "Pärnu maakond",
      "ncash": true,
      "lat": 58.37001111,
      "lon": 24.55008056,
      "i": "Sularaha tehingud pangaautomaatides "
    ]
    
    let model = Branch(data)
    XCTAssertNil(model.hasCoinStation)
    XCTAssert(model.name != "")
    XCTAssert(model.type == .branch)
  }
  
  func testCountry() {
    let data: [[String: Any]]? = TestHelper.readDataFromFile(with: "lithuania", format: "json")
    guard let json = data else {
      XCTAssert(false, "Data cant be nil")
      return
    }
    
    let country = Country.convert(dictList: json, to: .lithuania)
    
    XCTAssert(country.type.headerString == "Lithuania", "Header is wrong")
    XCTAssert(country.regions.first!.name == "Alytus", "Region alphabetical order is wrong")
    XCTAssert(country.regions.first!.branches.first!.name == "DAINAVOS KAC", "Branch alphabetical order is wrong")
  }
}
