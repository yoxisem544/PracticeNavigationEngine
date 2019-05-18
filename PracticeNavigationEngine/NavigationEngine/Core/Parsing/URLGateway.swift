//
//  URLGateway.swift
//  PracticeNavigationEngine
//
//  Created by David on 2019/5/18.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation
import PromiseKit

public final class URLGateway {
  
  static let domain = "me.rooit.URLGateway"
  
  enum ErrorCode: Int {
    case missingURLScheme
    case unsupportedUniversalLink
    case generic
  }
  
  private let universalLinkConverter: UniversalLinkConverter
  private let settings: DeepLinkSettingsProtocol
  
  public init(settings: DeepLinkSettingsProtocol) {
    self.settings = settings
    self.universalLinkConverter = UniversalLinkConverter(settings: settings)
  }
  
  public func handleURL(_ url: URL) -> Promise<DeepLink> {
    return Promise { seal in
      guard let scheme = url.scheme?.lowercased() else {
        let error = NSError(domain: URLGateway.domain, code: ErrorCode.missingURLScheme.rawValue, userInfo: nil)
        throw error
      }
      
      // 1. check if universal link
      if settings.universalLinkSchemes.contains(scheme) {
        if let deepLink = universalLinkConverter.deeLink(forUniversalLink: url) {
          seal.fulfill(deepLink)
        } else {
          let unsupportedError = NSError(domain: URLGateway.domain, code: ErrorCode.unsupportedUniversalLink.rawValue, userInfo: nil)
          seal.reject(unsupportedError)
        }
      }
      
      // 2. check if deep link
      else if settings.internalDeepLinkSchemes.contains(scheme) {
        seal.fulfill(url)
      }
      
      // 3. generic error
      else {
        let genericError = NSError(domain: URLGateway.domain, code: ErrorCode.generic.rawValue, userInfo: nil)
        seal.reject(genericError)
      }
    }
  }
  
}
