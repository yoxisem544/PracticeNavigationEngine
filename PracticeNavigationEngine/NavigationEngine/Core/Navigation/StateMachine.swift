//
//  StateMachine.swift
//  PracticeNavigationEngine
//
//  Created by David on 2019/5/19.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation
import Stateful

struct TransitionOptions: OptionSet {
  let rawValue: Int
  
  static let basicTransitions = TransitionOptions(rawValue: 1 << 0)
  static let userLoggedIn     = TransitionOptions(rawValue: 1 << 1)
  static let userLoggedOut    = TransitionOptions(rawValue: 1 << 2)
}

public enum EventType: Int, CaseIterable {
  case popEverything
  case goToHome
  case goToSettings
  case goToPaymentSettings
  case goToPaymentMethodInSettings
  case goToPaymentPinCodeInSettings
  case goToPaymentContactInSettings
  case goToNotificationsInSettings
}

public enum StateType: Int, CaseIterable {
  case allPoppedToRoot
  case home
  case settings
  case paymentInSettings
  case paymentMethodInSettings
  case paymentPinCodeInSettings
  case paymentContactInSettings
  case notificationsInSettings
}

public final class StateMachine: Stateful.StateMachine<StateType, EventType> {
  typealias StateTransition = Transition<StateType, EventType>
  
  init(initialState: StateType, allowedTransitions: TransitionOptions) {
    super.init(initialState: initialState)
    
    if allowedTransitions.contains(.basicTransitions) {
      addBasicTransitions()
    }
    
    if allowedTransitions.contains(.userLoggedIn) {
      addUserLoggedInTransitions()
    }
    
    if allowedTransitions.contains(.userLoggedOut) {
      addUserLoggedOutTransitions()
    }
  }
  
  func addBasicTransitions() {
    add(transition: StateTransition(with: .goToHome,
                                    from: .allPoppedToRoot, 
                                    to: .home))
    add(transition: StateTransition(with: .goToSettings,
                                    from: .allPoppedToRoot, 
                                    to: .settings))
    add(transition: StateTransition(with: .goToNotificationsInSettings,
                                    from: .settings,
                                    to: .notificationsInSettings))
    add(transition: StateTransition(with: .goToPaymentSettings,
                                    from: .settings,
                                    to: .paymentInSettings))
    
    // move backward
    add(transition: StateTransition(with: .popEverything,
                                    from: .allPoppedToRoot,
                                    to: .allPoppedToRoot))
    add(transition: StateTransition(with: .popEverything,
                                    from: .home,
                                    to: .allPoppedToRoot))
    add(transition: StateTransition(with: .popEverything,
                                    from: .settings,
                                    to: .allPoppedToRoot))
    add(transition: StateTransition(with: .popEverything,
                                    from: .notificationsInSettings,
                                    to: .allPoppedToRoot))
    add(transition: StateTransition(with: .popEverything,
                                    from: .paymentInSettings,
                                    to: .allPoppedToRoot))
    add(transition: StateTransition(with: .popEverything,
                                    from: .paymentMethodInSettings,
                                    to: .allPoppedToRoot))
    add(transition: StateTransition(with: .popEverything,
                                    from: .paymentPinCodeInSettings,
                                    to: .allPoppedToRoot))
    add(transition: StateTransition(with: .popEverything,
                                    from: .paymentContactInSettings,
                                    to: .allPoppedToRoot))
  }
  
  func addUserLoggedInTransitions() {
    add(transition: StateTransition(with: .goToPaymentMethodInSettings,
                                    from: .paymentInSettings,
                                    to: .paymentMethodInSettings))
    add(transition: StateTransition(with: .goToPaymentPinCodeInSettings,
                                    from: .paymentInSettings,
                                    to: .paymentPinCodeInSettings))
    add(transition: StateTransition(with: .goToPaymentContactInSettings,
                                    from: .paymentInSettings,
                                    to: .paymentContactInSettings))
  }
  
  func addUserLoggedOutTransitions() {
    
  }
  
}
