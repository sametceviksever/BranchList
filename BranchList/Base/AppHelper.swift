//
//  LaunchHelper.swift
//  BranchList
//
//  Created by Samet Çeviksever on 14.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public protocol AppHelperDelegate: class{
  func didUpdate(countries: [Country])
}

public class AppHelper {
  static var shared: AppHelper = AppHelper()
  
  public private(set) var countries: [Country] = [] {
    didSet{
      delegate?.didUpdate(countries: countries)
    }
  }
  weak var delegate: AppHelperDelegate?
  
  public func prepareData(isLaunch: Bool) {
    let shouldRequest = isLaunch || File.shared.shouldRequestFile
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
        countries = []
        downloadDatas()
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
        guard let json = response.value else {return}
        File.shared.writeFile(for: type, json: json)
        File.shared.updateFileOperationDate()
        self.appendData(with: json, for: type)
      }
      Network.shared.call(with: request)
    }
  }
  
  private func appendData(with json:[[String: Any]], for type: CountryEnum) {
    let country = Country.convert(dictList: json, to: type)
    countries.append(country)
    countries.sort(by: {$0.type.rawValue > $1.type.rawValue})
  }
}
