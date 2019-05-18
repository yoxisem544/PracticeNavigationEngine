//
//  UniversalLinkConverter.swift
//  PracticeNavigationEngine
//
//  Created by David on 2019/5/18.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation

public final class UniversalLinkConverter {
  
  private let settings: DeepLinkSettingsProtocol
  private let deepLinkFactory: DeepLinkFactory
  
  public init(settings: DeepLinkSettingsProtocol) {
    self.settings = settings
    self.deepLinkFactory = DeepLinkFactory(scheme: settings.internalDeepLinkSchemes.first!,
                                           host: settings.internalDeepLinkHost)
  }
  
  public func deeLink(forUniversalLink url: UniversalLink) -> DeepLink? {
    guard 
      let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
      let pathComponents = components.url?.pathComponents,
      let scheme = components.scheme,
      let host = components.host,
      settings.universalLinkHosts.contains(host),
      settings.universalLinkSchemes.contains(scheme) else { return nil }
    
    let queryItems = components.queryItems
    
    switch pathComponents.count {
    case 4:
      switch (pathComponents[1], pathComponents[2], pathComponents[3]) {
      case ("settings", "payment", "method"):
        return deepLinkFactory.settings.paymentMethodURL()
      case ("settings", "payment", "pincode"):
        return deepLinkFactory.settings.paymentPinCodeURL()
      case ("settings", "payment", "contact"):
        return deepLinkFactory.settings.paymentContactURL()
      default:
        return nil
      }
      
    case 2:
      switch (pathComponents[1]) {
      case ("home"):
        return deepLinkFactory.homeURL()
      case ("settings"):
        return deepLinkFactory.settings.url()
      default:
        return nil
      }
      
    case 1:
      return deepLinkFactory.homeURL()
      
    default:
      return deepLinkFactory.homeURL()
    }
  }
  
}
