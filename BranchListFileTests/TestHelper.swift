//
//  TestHelper.swift
//  BranchListFileTests
//
//  Created by Samet Çeviksever on 15.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

struct TestHelper {
  static func readDataFromFile<T> (with fileName:String, format: String) -> T?
  {
    if let path = Bundle.main.path(forResource: fileName, ofType: format) {
      do {
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        let response: T? = data.jsonObject()
        return response
        
      } catch let error {
        print(error.localizedDescription)
      }
    } else {
      print("Invalid filename/path.")
    }
    return nil
  }
}
