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
  func thereIsAnAlert(alertView: UIAlertController)
}

public class AppHelper {
  static var shared: AppHelper = AppHelper()
  private var alert: UIAlertController?
  
  public private(set) var countries: [Country] = []
  
  weak var delegate: AppHelperDelegate? {
    didSet{
      checkDataAndSend()
      if alert != nil {
        delegate?.thereIsAnAlert(alertView: alert!)
        alert = nil
      }
    }
  }
  
  public func prepareData(isLaunch: Bool) {
    let shouldRequest = isLaunch || File.shared.shouldRequestFile
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
        if let error = response.error {
          self.showError(error: error)
        }
        
        guard let json = response.value else {return}
        File.shared.writeFile(for: type, json: json)
        File.shared.updateFileOperationDate()
        self.appendData(with: json, for: type)
      }
      Network.shared.call(with: request)
    }
  }
  
  private func showError(error: Error) {
    let message = "Somethings went wrong when calling api. I'll try one more time :)"
    let alertView = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    
    alertView.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { [unowned self] (_) in
      self.countries = []
      self.downloadDatas()
    }))
    
    if delegate != nil {
      delegate?.thereIsAnAlert(alertView: alertView)
    } else {
      alert = alertView
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
