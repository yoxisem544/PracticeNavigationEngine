//
//  DeepLinkSettings.swift
//  PracticeNavigationEngine
//
//  Created by David on 2019/5/18.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation

class DeepLinkSettings: DeepLinkSettingsProtocol {
  
  var universalLinkSchemes: [String] { return ["https", "http"] }
  var universalLinkHosts: [String] { return ["rooit.me", "www.rooit.me"] }
  
  var internalDeepLinkSchemes: [String] { return ["roo", "rooit", "rooit-us", "rooit-tw"] }
  var internalDeepLinkHost: String { return "roo.me" }
}
