//
//  Network.swift
//  BranchList
//
//  Created by Samet Çeviksever on 13.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public typealias NetworkResponseBlock<T> = ((URLResponseType<T>) -> Void)

public final class Network {
  static var shared: Network = Network()
  
  private init() {
    let countries = CountryEnum.countries
    for country in countries {
      let cookieProperties: [HTTPCookiePropertyKey: Any] = [HTTPCookiePropertyKey.name: "Swedbank-Embedded",
                              HTTPCookiePropertyKey.value: "iphone-app",
                              HTTPCookiePropertyKey.domain: country.domain,
                              HTTPCookiePropertyKey.path: "/",
                              HTTPCookiePropertyKey.expires: Date().addingTimeInterval(31536000)]
      
      let cookie = HTTPCookie(properties: cookieProperties)
      HTTPCookieStorage.shared.setCookie(cookie!)
    }
  }
  
  public final func call<T: Request> (with request: T){
    guard let urlRequest = request.getURLRequest() else {
      let defaultError = NetworkError.default
      request.handler?(.error(defaultError))
      return
    }
    
    URLSession.shared.dataTask(with: urlRequest) {[unowned self] (data, urlResponse, error) in
      DispatchQueue.main.async {
        if let error = error {
          let reqError = NetworkError.custom(error)
          request.handler?(.error(reqError))
          return
        } else if let error = self.lookHttpError(urlResponse) {
          request.handler?(.error(error))
          return
        }
        
        guard let data = data else {
          let defaultError = NetworkError.default
          request.handler?(.error(defaultError))
          return
        }
        
        if let json: T.responseType = data.jsonObject() {
          request.handler?(.success(json))
          return
        }
        let defaultError = NetworkError.default
        request.handler?(.error(defaultError))
        return
      }
      }.resume()
  }
  
  private func lookHttpError(_ response: URLResponse?) -> NetworkError? {
    guard let httpResponse = response as? HTTPURLResponse else {
      return .default
    }
    
    let code = httpResponse.statusCode
    if code == 200 {
      return nil
    }
    
    return .http(code)
  }
}
