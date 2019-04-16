//
//  Request.swift
//  BranchList
//
//  Created by Samet Çeviksever on 13.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public protocol Request {
  associatedtype responseType
  
  var methodType: MethodType {get}
  var contentType: ContentType {get}
  var timeOut: TimeInterval {get}
  var cachePolicy: URLRequest.CachePolicy {get}
  var url: String {get}
  var body: [String: Any]? {get}
  var headers: [String: String] {get}
  
  var handler: NetworkResponseBlock<responseType>? {get set}
}

public extension Request {
  var timeOut: TimeInterval {return 60}
  var contentType: ContentType {return .json}
  var cachePolicy: URLRequest.CachePolicy {return .useProtocolCachePolicy}
  var headers: [String: String] {return [:]}
  var body: [String: Any]? {return nil}
  
  func getURLRequest() -> URLRequest? {
    guard let url = URL(string: url) else {return nil}
    var urlRequest = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeOut)
    var mutableHeaders = headers
    let cookies = HTTPCookie.requestHeaderFields(with: HTTPCookieStorage.shared.cookies(for: url) ?? [])
    for cookie in cookies {
      mutableHeaders[cookie.key] = cookie.value
    }
    urlRequest.allHTTPHeaderFields = mutableHeaders
    urlRequest.httpMethod = methodType.rawValue
    urlRequest.timeoutInterval = timeOut
    if contentType != .none{
      urlRequest.addValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
    }
    setBody(to: &urlRequest)
    
    return urlRequest
  }
  
  private func setBody(to request:inout URLRequest) {
    switch methodType {
    case .post:
      request.httpBody = body?.data
    case .get:
      guard let body = body ,
        var urlString = request.url?.absoluteString else {return}
      var bodyString = "?"
      body.forEach({bodyString = String(format: "%@%@=\($0.value)&",bodyString,$0.key)})
      bodyString = String(bodyString.dropLast())
      urlString += bodyString
      request.url = URL(string: urlString)
    default:
      break
    }
  }
}
