//
//  BranchListFileTests.swift
//  BranchListFileTests
//
//  Created by Samet Çeviksever on 13.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import XCTest
@testable import BranchList

class BranchListFileTests: XCTestCase {
  
  func testWriteAndRead() {
    let json: [[String: Any]] = [["test": "test"]]
    let result = File.shared.writeFile(for: .test, json: json)
    XCTAssert(result)
    let read = File.shared.readFile(for: .test)
    XCTAssertNotNil(read)
    XCTAssertNotNil(read?.first!["test"] as? String)
    XCTAssert(read?.first?["test"] as? String == json.first?["test"] as? String)
  }
  
  func testOverHour() {
    let lastFileOperationKey = "requestTime"
    let hourInterval: Double = 3601
    let hourBefore = Date().addingTimeInterval(-hourInterval)
    UserDefaults.standard.set(hourBefore, forKey: lastFileOperationKey)
    
    let result = File.shared.checkLastFileUpdateOverHour()
    
    XCTAssert(result)
  }
  
}
