//
//  BranchListNetworkTest.swift
//  BranchListFileTests
//
//  Created by Samet Çeviksever on 13.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import XCTest
@testable import BranchList

class BranchListNetworkTest: XCTestCase {

  func testNetworkSuccess() {
    let promise = expectation(description: "Success")
    var response: URLResponseType<[[String: Any]]>!
    
    var request = BankLocationRequest(country: .estonia)
    request.handler = { res in
      response = res
      promise.fulfill()
    }
    
    Network.shared.call(with: request)
    
    wait(for: [promise], timeout: 30)
    
    XCTAssertNil(response.error)
    XCTAssertNotNil(response.value)
  }
}
