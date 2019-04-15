//
//  FileOperation.swift
//  BranchList
//
//  Created by Samet Çeviksever on 13.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public struct File {
  private let lastFileOperationKey = "requestTime"
  private let fileFormat = "json"
  
  public static var shared: File = File()
  
  public var shouldRequestFile: Bool {
    get {
      let dateCheck = checkLastFileUpdateOverHour()
      let fileCheck = checkAnyMissingFile()
      
      return dateCheck || fileCheck
    }
  }
  
  public func checkLastFileUpdateOverHour() -> Bool{
    guard let lastRequest = UserDefaults.standard.object(forKey: lastFileOperationKey) as? Date else{
      return true
    }
    let minuteInterval: Double = 60
    let hourInterval: Double = 60
    let oneHourLater = lastRequest.addingTimeInterval(minuteInterval * hourInterval)
    if Date() > oneHourLater {
      return true
    }
    
    return false
  }
  
  public func checkAnyMissingFile() -> Bool {
    let countries: [CountryEnum] = CountryEnum.countries
    for country in countries{
      if !isExistFile(for: country) {
        return true
      }
    }
    
    return false
  }
  
  public func updateFileOperationDate() {
    UserDefaults.standard.set(Date(), forKey: lastFileOperationKey)
  }
  
  @discardableResult
  public func writeFile(for country: CountryEnum, json: [[String: Any]]) -> Bool{
    
    let data = json.data
    guard let folderUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return false}
    
    let url = folderUrl.appendingPathComponent(String(format: "%@.%@", country.rawValue, fileFormat))
    
    do {
      try data?.write(to: url)
      return true
    } catch {
      return false
    }
  }
  
  public func readFile(for country: CountryEnum) -> [[String: Any]]? {
    guard let folderUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
    
    let url = folderUrl.appendingPathComponent(String(format: "%@.%@", country.rawValue, fileFormat))
    if let data = try? Data(contentsOf: url, options: .mappedIfSafe) {
      let json: [[String: Any]]? = data.jsonObject()
      return json
    }
    return nil
  }
  
  private func isExistFile(for country: CountryEnum) -> Bool{
    guard let folderUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return false}
    let url = folderUrl.appendingPathComponent(String(format: "%@.%@", country.rawValue, fileFormat))
    
    do{
      let result = try url.checkResourceIsReachable()
      return result
    } catch{
      return false
    }
  }
}
