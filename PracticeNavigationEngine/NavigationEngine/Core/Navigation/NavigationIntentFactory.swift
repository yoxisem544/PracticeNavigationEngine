//
//  NavigationIntentFactory.swift
//  PracticeNavigationEngine
//
//  Created by David on 2019/5/18.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation

public enum NavigationIntent: Equatable {
  case goToHome
  case goToSettings
  case goToPaymentMethodInSettings
  case goToPaymentPinCodeInSettings
  case goToPaymentContactInSettings
  case goToNotificationInSettings
}

public final class NavigationIntentFactory {
  
  static let domain = "me.rooit.navigationIntentFactory"
  
  enum ErrorCode: Int {
    case malformedURL
    case unsupportedURL
  }
  
  public func intent(for url: DeepLink) -> Result<NavigationIntent, Error> {
    guard  
      let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
      let pathComponents = components.url?.pathComponents
    else { 
      let error = NSError(domain: NavigationIntentFactory.domain, code: ErrorCode.malformedURL.rawValue, userInfo: nil)
      return .failure(error) 
    }
    
    let queryItems = components.queryItems
    
    switch pathComponents.count {
    case 4:
      switch (pathComponents[1], pathComponents[2], pathComponents[3]) {
      case ("settings", "payment", "method"):
        return .success(.goToPaymentMethodInSettings)
      case ("settings", "payment", "pincode"):
        return .success(.goToPaymentPinCodeInSettings)
      case ("settings", "payment", "contact"):
        return .success(.goToPaymentContactInSettings)
      default: break
      }
      
    case 3:
      switch (pathComponents[1], pathComponents[2]) {
      case ("settings", "notifications"):
        return .success(.goToNotificationInSettings)
      default: break
      }
      
    case 2:
      switch (pathComponents[1]) {
      case ("settings"):
        return .success(.goToSettings)
      case ("home"):
        return .success(.goToHome)
      default: break
      }
      
    case 1:
      return .success(.goToHome)
      
    default: break
    }
    
    let error = NSError(domain: NavigationIntentFactory.domain, code: ErrorCode.unsupportedURL.rawValue, userInfo: nil)
    return .failure(error)
  }
  
}
