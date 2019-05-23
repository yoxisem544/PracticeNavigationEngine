//
//  StateMachine.swift
//  PracticeNavigationEngine
//
//  Created by David on 2019/5/19.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation

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

public final class StateMachine: StateMachineBase<StateType, EventType> {
  
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
    add(stateTransitions: 
      .on(event: .goToHome, stateChangeFrom: .allPoppedToRoot, to: .home),
      .on(event: .goToSettings, stateChangeFrom: .allPoppedToRoot, to: .settings),
      .on(event: .goToNotificationsInSettings, stateChangeFrom: .settings, to: .notificationsInSettings),
      .on(event: .goToPaymentSettings, stateChangeFrom: .settings, to: .paymentInSettings)
    )
    
    // move backward
    add(stateTransitions: 
      .on(event: .popEverything, stateChangeFrom: .allPoppedToRoot, to: .allPoppedToRoot),
      .on(event: .popEverything, stateChangeFrom: .home, to: .allPoppedToRoot),
      .on(event: .popEverything, stateChangeFrom: .settings, to: .allPoppedToRoot),
      .on(event: .popEverything, stateChangeFrom: .notificationsInSettings, to: .allPoppedToRoot),
      .on(event: .popEverything, stateChangeFrom: .paymentInSettings, to: .allPoppedToRoot),
      .on(event: .popEverything, stateChangeFrom: .paymentMethodInSettings, to: .allPoppedToRoot),
      .on(event: .popEverything, stateChangeFrom: .paymentPinCodeInSettings, to: .allPoppedToRoot),
      .on(event: .popEverything, stateChangeFrom: .paymentContactInSettings, to: .allPoppedToRoot)
    )
  }
  
  func addUserLoggedInTransitions() {
    add(stateTransitions: 
      .on(event: .goToPaymentMethodInSettings, stateChangeFrom: .paymentInSettings, to: .paymentMethodInSettings),
      .on(event: .goToPaymentPinCodeInSettings, stateChangeFrom: .paymentInSettings, to: .paymentPinCodeInSettings),
      .on(event: .goToPaymentContactInSettings, stateChangeFrom: .paymentInSettings, to: .paymentContactInSettings)
    )
  }
  
  func addUserLoggedOutTransitions() {
    
  }
  
}
