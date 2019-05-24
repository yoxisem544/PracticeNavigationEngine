//
//  SettingsFlowController.swift
//  PracticeNavigationEngine
//
//  Created by David on 2019/5/24.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

public final class SettingsFlowController: SettingsFlowControllerProtocol {
  
  public let parentFlowController: RootFlowControllerProtocol
  private let navigationController: UINavigationController
  
  init(with parentFlowController: RootFlowControllerProtocol, navigationController: UINavigationController) {
    self.parentFlowController = parentFlowController
    self.navigationController = navigationController
  }
  
  public func goBackToRoot(animated: Bool) -> Future {
    return Future.value(())
  }
  
  public func goToNotifications(animated: Bool) -> Future {
    return Future.value(())
  }
  
  public func goToPayment(animated: Bool) -> Future {
    return Future.value(())
  }
  
  public func goToPaymentMethod(animated: Bool) -> Future {
    return Future.value(())
  }
  
  public func goToPaymentPinCode(animated: Bool) -> Future {
    return Future.value(())
  }
  
  public func goToPaymentContact(animated: Bool) -> Future {
    return Future.value(())
  }
  
}
