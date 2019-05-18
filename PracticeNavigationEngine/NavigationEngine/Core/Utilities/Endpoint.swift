//
//  Endpoint.swift
//  PracticeNavigationEngine
//
//  Created by David on 2019/5/18.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation

struct Endpoint {
  let scheme: String
  let host: String
  /// Path should start with a '/'
  /// e.g. /some/thing/likethis
  var path: String
  var queryItems: [URLQueryItem]? = nil
  
  public init(scheme: String, host: String, path: String, queryItems: [URLQueryItem]? = nil) {
    self.scheme = scheme
    self.host = host
    self.path = path
    self.queryItems = queryItems
  }
}

extension Endpoint {
  
  var url: URL {
    var components = URLComponents()
    components.scheme = scheme
    components.host = host
    components.path = path
    components.queryItems = queryItems
    return components.url!
  }
  
}
