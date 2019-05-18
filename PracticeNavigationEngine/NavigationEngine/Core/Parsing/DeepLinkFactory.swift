//
//  DeepLinkFactory.swift
//  PracticeNavigationEngine
//
//  Created by David on 2019/5/18.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation

public protocol DeepLinkFactoryChildNamespace {
  var scheme: String { get }
  var host: String { get }
  init(factory: DeepLinkFactory)
}

public class DeepLinkFactory {
  let scheme: String
  let host: String
  // MARK: - Namespaces
  lazy public private(set) var settings: Settings = {
    return Settings.init(factory: self)
  }()
  
  public init(scheme: String, host: String) {
    self.scheme = scheme
    self.host = host
  }
  
  // MARK: - Namespaces
  public struct Settings: DeepLinkFactoryChildNamespace {
    public var scheme: String
    public var host: String
    
    public init(factory: DeepLinkFactory) {
      self.scheme = factory.scheme
      self.host = factory.host
    } 
  }

}

extension DeepLinkFactory {
  
  func homeURL() -> DeepLink {
    return Endpoint(scheme: scheme, 
                    host: host, 
                    path: "/home").url
  }
  
}

extension DeepLinkFactory.Settings {
    
  func url() -> DeepLink {
    return Endpoint(scheme: scheme,
                    host: host, 
                    path: "/settings").url
  }
  
  func paymentMethodURL() -> DeepLink {
    return Endpoint(scheme: scheme,
                    host: host, 
                    path: "/payment/method").url
  }
  
  func paymentPinCodeURL() -> DeepLink {
    return Endpoint(scheme: scheme,
                    host: host, 
                    path: "/payment/pincode").url
  }
  
  func paymentContactURL() -> DeepLink {
    return Endpoint(scheme: scheme,
                    host: host, 
                    path: "/payment/contact").url
  }
  
}
