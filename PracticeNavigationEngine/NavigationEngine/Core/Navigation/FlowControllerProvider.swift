//
//  FlowControllerProvider.swift
//  PracticeNavigationEngine
//
//  Created by David on 2019/5/23.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation
import PromiseKit

public final class FlowControllerProvider {
  
  public let rootFlowController: RootFlowControllerProtocol
  
  public init(rootFlowController: RootFlowControllerProtocol) {
    self.rootFlowController = rootFlowController
  }
  
  public var homeFlowController: HomeFlowControllerProtocol {
    return rootFlowController.homeFlowController!
  }
  
  public var settingsFlowController: SettingsFlowControllerProtocol {
    return rootFlowController.settingsFlowController!
  }
  
}

public protocol RootFlowControllerProtocol {
  
  var homeFlowController: HomeFlowControllerProtocol? { get }
  var settingsFlowController: SettingsFlowControllerProtocol? { get }
  
  func setup()
  
  @discardableResult func allGoBackToRoot(animated: Bool) -> Promise<Bool>
  @discardableResult func goToHomeSection() -> Promise<Bool>
  @discardableResult func goToSettingsSection() -> Promise<Bool>
}

public protocol HomeFlowControllerProtocol {
  var parentFlowController: RootFlowControllerProtocol? { get }
  
  @discardableResult func goBackToRoot(animated: Bool) -> Promise<Bool>
}

public protocol SettingsFlowControllerProtocol {
  var parentFlowController: RootFlowControllerProtocol? { get }
  
  @discardableResult func goBackToRoot(animated: Bool) -> Promise<Bool>
  @discardableResult func goToNotifications(animated: Bool) -> Promise<Bool>
  @discardableResult func goToPayment(animated: Bool) -> Promise<Bool>
  @discardableResult func goToPaymentMethod(animated: Bool) -> Promise<Bool>
  @discardableResult func goToPaymentPinCode(animated: Bool) -> Promise<Bool>
  @discardableResult func goToPaymentContact(animated: Bool) -> Promise<Bool>
}
