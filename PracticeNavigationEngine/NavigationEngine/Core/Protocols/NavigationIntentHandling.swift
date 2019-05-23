//
//  NavigationIntentHandling.swift
//  PracticeNavigationEngine
//
//  Created by David on 2019/5/19.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation
import PromiseKit

protocol NavigationIntentHandling {
  func handle(intent: NavigationIntent) -> Promise<Bool>
}
