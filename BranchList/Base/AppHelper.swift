//
//  LaunchHelper.swift
//  BranchList
//
//  Created by Samet Çeviksever on 14.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

public protocol AppHelperDelegate: class{
  func didUpdate(countries: [Country])
  func thereIsAnError(_ error: Error)
}

public class AppHelper {
  static var shared: AppHelper = AppHelper()
  private var error: Error?
  
  public private(set) var countries: [Country] = []
  
  weak var delegate: AppHelperDelegate? {
    didSet{
      checkDataAndSend()
      if error != nil {
        delegate?.thereIsAnError(error!)
        error = nil
      }
    }
  }
  
  public func prepareData(forceDownload: Bool) {
    let shouldRequest = forceDownload || File.shared.shouldRequestFile
    countries = []
    if shouldRequest {
      downloadDatas()
    } else {
      readDatasFromFiles()
    }
  }
  
  private func readDatasFromFiles() {
    let countryTypes: [CountryEnum] = CountryEnum.countries
    for type in countryTypes {
      guard let json = File.shared.readFile(for: type) else {
        prepareData(forceDownload: true)
        return
      }
      appendData(with: json, for: type)
    }
  }
  
  private func downloadDatas() {
    let countryTypes: [CountryEnum] = CountryEnum.countries
    for type in countryTypes {
      var request = BankLocationRequest(country: type)
      request.handler = {[unowned self] response in
        if let error = response.error {
          self.handle(error)
        }
        
        guard let json = response.value else {return}
        File.shared.writeFile(for: type, json: json)
        File.shared.updateFileOperationDate()
        self.appendData(with: json, for: type)
      }
      Network.shared.call(with: request)
    }
  }
  
  private func handle(_ error: Error) {
    let countries = CountryEnum.countries
    for country in countries {
      File.shared.deleteFile(for: country)
    }
    
    if delegate != nil {
      delegate?.thereIsAnError(error)
    } else {
      self.error = error
    }
  }
  
  private func checkDataAndSend() {
    if countries.count == CountryEnum.countries.count {
      delegate?.didUpdate(countries: countries)
    }
  }
  
  private func appendData(with json:[[String: Any]], for type: CountryEnum) {
    let country = Country.convert(dictList: json, to: type)
    countries.append(country)
    countries.sort(by: {$0.type.rawValue > $1.type.rawValue})
    
    checkDataAndSend()
  }
}
