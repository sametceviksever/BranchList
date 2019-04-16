//
//  BranchListViewModelTest.swift
//  BranchListFileTests
//
//  Created by Samet Çeviksever on 16.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import XCTest
@testable import BranchList

class BranchListViewModelTest: XCTestCase {
  
  private var data: [Country] = []
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    super.setUp()
    let json: [[String: Any]]? = File.readDataFromFile(with: "lithuania", format: "json")
    let country = Country.convert(dictList: json!, to: .lithuania)
    data = [country]
  }
  
  override func tearDown() {
    data = []
    super.tearDown()
  }
  
  func testRegionViewModel() {
    let viewModel = RegionListViewModel(countries: data)
    let indexPath = IndexPath(row: 6, section: 0)
    XCTAssert(viewModel.getRegion(at: indexPath).name == data[0].regions[indexPath.row].name)
  }
}
