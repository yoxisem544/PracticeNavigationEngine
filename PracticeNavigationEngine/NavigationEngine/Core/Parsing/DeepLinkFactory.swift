//
//  DeepLinkFactory.swift
//  PracticeNavigationEngine
//
//  Created by David on 2019/5/18.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation

public class DeepLinkFactory {
  let scheme: String
  let host: String
  
  public init(scheme: String, host: String) {
    self.scheme = scheme
    self.host = host
  }
}

extension DeepLinkFactory {
  
  func homeURL() -> DeepLink {
    return Endpoint(scheme: scheme, 
                    host: host, 
                    path: "/home").url
  }
  
  func settingsURL() -> DeepLink {
    return Endpoint(scheme: scheme,
                    host: host, 
                    path: "/settings").url
  }
  
}
