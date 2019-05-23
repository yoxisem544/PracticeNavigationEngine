//
//  DeepLinkConstants.swift
//  PracticeNavigationEngine
//
//  Created by David on 2019/5/18.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation

public typealias DeepLink = URL
public typealias UniversalLink = URL

public enum UserStatus: CaseIterable {
  case loggedIn
  case loggedOut
}
