//
//  HomeFlowController.swift
//  PracticeNavigationEngine
//
//  Created by David on 2019/5/24.
//  Copyright © 2019 David. All rights reserved.
//

import PromiseKit

public final class HomeFlowController: HomeFlowControllerProtocol {
  
  public let parentFlowController: RootFlowControllerProtocol
  private let navigationController: UINavigationController
  
  init(with parentFlowController: RootFlowControllerProtocol, navigationController: UINavigationController) {
    self.parentFlowController = parentFlowController
    self.navigationController = navigationController
  }
  
  @discardableResult
  public func goBackToRoot(animated: Bool) -> Future {
    return Future { seal in 
      navigationController.dismiss(animated: animated, completion: nil)
      // cannot use the completion to fulfill the future since it might never get called
      seal.fulfill(())
    }
  }
  
}
