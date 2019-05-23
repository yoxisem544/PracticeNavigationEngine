//
//  NavigationIntentHandler.swift
//  PracticeNavigationEngine
//
//  Created by David on 2019/5/19.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation
import PromiseKit

public final class NavigationIntentHandler: NavigationIntentHandling {
  
  let flowControllerProvider: FlowControllerProvider
  let userStatusProvider: UserStatusProviding
  var navigationTransitioner: NavigationTransitioner!
  private weak var navigationTransitionerDataSource: NavigationTransitionerDataSource?
  
  init(flowControllerProvider: FlowControllerProvider,
       userStatusProvider: UserStatusProviding,
       navigationTransitionerDataSource: NavigationTransitionerDataSource?) {
    self.flowControllerProvider = flowControllerProvider
    self.userStatusProvider = userStatusProvider
    self.navigationTransitionerDataSource = navigationTransitionerDataSource
  }
  
  var allowedTransitions: TransitionOptions {
    get {
      switch userStatusProvider.userStatus {
      case .loggedIn:
        return [.basicTransitions, .userLoggedIn]
      case .loggedOut:
        return [.basicTransitions, .userLoggedOut]
      }
    }
  }
  
  func handle(intent: NavigationIntent) -> Promise<Bool> {
    let stateMachine = StateMachine(initialState: .allPoppedToRoot, allowedTransitions: allowedTransitions)
    navigationTransitioner = NavigationTransitioner(flowControllerProvider: flowControllerProvider, stateMachine: stateMachine)
    navigationTransitioner.dataSource = navigationTransitionerDataSource
    
    switch intent {
    case .goToHome:
      return navigationTransitioner.goToRoot(animated: false)
        .then({ _ -> Promise<Bool> in 
          self.navigationTransitioner.goToHome(animated: false)
        })
      
    case .goToSettings:
      return navigationTransitioner.goToRoot(animated: false)
        .then({ _ -> Promise<Bool> in 
          self.navigationTransitioner.goToSettings(animated: false)
        })
      
    case .goToNotificationInSettings:
      return navigationTransitioner.goToRoot(animated: false)
        .then({ _ -> Promise<Bool> in
          self.navigationTransitioner.goToNotificationInSettings(animated: true)
        })
      
    case .goToPaymentMethodInSettings:
      switch userStatusProvider.userStatus {
      case .loggedIn:
        return navigationTransitioner.goToRoot(animated: false)
          .then({ _ -> Promise<Bool> in
            self.navigationTransitioner.goToPaymentMethodInSettings(animated: true)
          })
      case .loggedOut:
        return Promise.value(false)
      }
      
    case .goToPaymentPinCodeInSettings:
      switch userStatusProvider.userStatus {
      case .loggedIn:
        return navigationTransitioner.goToRoot(animated: false)
          .then({ _ -> Promise<Bool> in
            self.navigationTransitioner.goToPaymentPinCodeInSettings(animated: true)
          })
      case .loggedOut:
        return Promise.value(false)
      }
      
    case .goToPaymentContactInSettings:
      return navigationTransitioner.goToRoot(animated: false)
        .then({ _ -> Promise<Bool> in
          self.navigationTransitioner.goToPaymentContactInSettings(animated: true)
        })
    }
  }
  
}
