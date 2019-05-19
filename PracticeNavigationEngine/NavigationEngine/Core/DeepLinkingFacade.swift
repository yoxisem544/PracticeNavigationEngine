//
//  DeepLinkingFacade.swift
//  PracticeNavigationEngine
//
//  Created by David on 2019/5/18.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation
import PromiseKit

public final class DeepLinkingFacade {
  
  static let domain = "me.rooit.deepLinkingFacade"
  
  enum ErrorCode: Int {
    case couldNotHandleURL
    case couldNotHandleDeepLink
    case couldNotDeepLinkFromShortcutItem
    case couldNotDeepLinkFromSpotlightItem
  }
  
  private let urlGateway: URLGateway
  private let settings: DeepLinkSettingsProtocol
  private let navigationIntentFactory: NavigationIntentFactory
  
  public init(urlGateway: URLGateway, settings: DeepLinkSettingsProtocol) {
    self.urlGateway = urlGateway
    self.settings = settings
    self.navigationIntentFactory = NavigationIntentFactory()
  }
  
  @discardableResult
  public func handle(url: URL) -> Promise<Bool> {
    return Promise { seal in 
      urlGateway.handleURL(url)
        .done({ deepLink in 
          
        })
        .catch({ error in 
          let wrappedError = NSError(domain: DeepLinkingFacade.domain, code: ErrorCode.couldNotHandleURL.rawValue, userInfo: [NSUnderlyingErrorKey: error])
          seal.reject(wrappedError)
        })
    }
  }
  
  @discardableResult
  public func openDeepLink(_ deepLink: DeepLink) -> Promise<Bool> {
    let intent = navigationIntentFactory.intent(for: deepLink)
  }
  
}
