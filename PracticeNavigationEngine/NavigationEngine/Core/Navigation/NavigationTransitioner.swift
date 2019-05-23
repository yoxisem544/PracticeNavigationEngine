//
//  NavigationTransitioner.swift
//  PracticeNavigationEngine
//
//  Created by David on 2019/5/23.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation
import PromiseKit

public protocol NavigationTransitionerDataSource: class {
  
}

public final class NavigationTransitioner {
  
  static let domain = "me.rooit.navigationTransitioner"
  
  weak var dataSource: NavigationTransitionerDataSource?
  
  let flowControllerProvider: FlowControllerProvider
  let stateMachine: StateMachine
  
  enum ErrorCode: Int {
    case failedPerformingTransition
  }
  
  init(flowControllerProvider: FlowControllerProvider, stateMachine: StateMachine) {
    self.flowControllerProvider = flowControllerProvider
    self.stateMachine = stateMachine
  }
  
  func goToRoot(animated: Bool) -> Future {
    return performTransition(forEvent: .popEverything, autoclosure: 
      self.flowControllerProvider.rootFlowController.allGoBackToRoot(animated: animated)
    )
  }
  
  func goToHome(animated: Bool) -> Future {
    return performTransition(forEvent: .goToHome, autoclosure: 
      self.flowControllerProvider.rootFlowController.goToHomeSection()
    )
  }
  
  func goToSettings(animated: Bool) -> Future {
    return performTransition(forEvent: .goToHome, autoclosure: 
      self.flowControllerProvider.rootFlowController.goToSettingsSection()
    )
  }
  
  func goToNotificationInSettings(animated: Bool) -> Future { 
    return performTransition(forEvent: .goToNotificationsInSettings, autoclosure: 
      self.flowControllerProvider.settingsFlowController.goToNotifications(animated: animated)
    )
  }
  
  func goToPaymentMethodInSettings(animated: Bool) -> Future { 
    return performTransition(forEvent: .goToPaymentMethodInSettings, autoclosure: 
      self.flowControllerProvider.settingsFlowController.goToPaymentMethod(animated: animated)
    )
  }
  
  func goToPaymentPinCodeInSettings(animated: Bool) -> Future { 
    return performTransition(forEvent: .goToPaymentPinCodeInSettings, autoclosure: 
      self.flowControllerProvider.settingsFlowController.goToPaymentPinCode(animated: animated)
    )
  }
  
  func goToPaymentContactInSettings(animated: Bool) -> Future { 
    return performTransition(forEvent: .goToPaymentContactInSettings, autoclosure: 
      self.flowControllerProvider.settingsFlowController.goToPaymentContact(animated: animated)
    )
  }
  
}

extension NavigationTransitioner {
  
  fileprivate func performTransition(forEvent eventType: EventType, autoclosure: @autoclosure @escaping () -> Future) -> Future {
    return Promise { seal in 
      stateMachine.process(
        event: eventType, 
        execution: {
          // FIXME: - should execute view transition here and return promise?
          autoclosure()
            .done({ result in 
              seal.fulfill(result)
            })
            .catch({ e in 
              seal.reject(e)
            })
      },
        callback: { (result) in
          /**
           * If result == .success (i.e. the transition was performed):
           - the callback block is called twice
           - the `execution` block is called
           * If result == .failure (i.e. the transition cannot be performed):
           - the callback block is called once
           - the `execution` block is not called
           * We cannot therefore resolve the promise in case of success otherwise we would do it twice causing a crash.
           */
          if result == .failure {
            let error = NSError(domain: NavigationTransitioner.domain,
                                code: ErrorCode.failedPerformingTransition.rawValue, 
                                userInfo: [NSLocalizedFailureReasonErrorKey: "Could not perform transition."])
            seal.reject(error)
          }
      })
    }
  }
  
}
