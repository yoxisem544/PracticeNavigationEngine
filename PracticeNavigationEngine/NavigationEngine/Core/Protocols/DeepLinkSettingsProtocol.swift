//
//  DeepLinkSettingsProtocol.swift
//  PracticeNavigationEngine
//
//  Created by David on 2019/5/18.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation

public protocol DeepLinkSettingsProtocol {
  
  var universalLinkSchemes: [String] { get }
  var universalLinkHosts: [String] { get }
  
  var internalDeepLinkSchemes: [String] { get }
  var internalDeepLinkHost: String { get }
}
