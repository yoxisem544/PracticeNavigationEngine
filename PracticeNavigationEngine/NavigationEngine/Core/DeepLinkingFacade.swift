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
  
  private let flowControllerProvider: FlowControllerProvider
  private let navigationIntentHandler: NavigationIntentHandler
  private let urlGateway: URLGateway
  private let settings: DeepLinkSettingsProtocol
  private let userStatusProvider: UserStatusProviding
  private let navigationIntentFactory: NavigationIntentFactory
  
  
  public init(flowControllerProvider: FlowControllerProvider,
              settings: DeepLinkSettingsProtocol,
              navigationTransitionerDataSource: NavigationTransitionerDataSource,
              userStatusProvider: UserStatusProviding) {
    self.flowControllerProvider = flowControllerProvider
    self.userStatusProvider = userStatusProvider
    self.settings = settings
    self.urlGateway = URLGateway(settings: settings)
    self.navigationIntentFactory = NavigationIntentFactory()
    self.navigationIntentHandler = NavigationIntentHandler(
      flowControllerProvider: flowControllerProvider, 
      userStatusProvider: userStatusProvider, 
      navigationTransitionerDataSource: navigationTransitionerDataSource)
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
    let result = navigationIntentFactory.intent(for: deepLink)
    switch result {
    case .success(let intent):
      return navigationIntentHandler.handle(intent: intent)
    case .failure(let error):
      let wrappedError = NSError(domain: DeepLinkingFacade.domain, 
                                 code: ErrorCode.couldNotHandleDeepLink.rawValue,
                                 userInfo: [NSUnderlyingErrorKey: error])
      let pending = Promise<Bool>.pending()
      pending.resolver.reject(wrappedError)
      return pending.promise
    }
  }
  
}
