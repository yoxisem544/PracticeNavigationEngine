//
//  RootFlowController.swift
//  PracticeNavigationEngine
//
//  Created by David on 2019/5/24.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit
import PromiseKit

public final class RootFlowController: RootFlowControllerProtocol {
  
  private let tabBarController: RootTabBarController
  
  public var homeFlowController: HomeFlowControllerProtocol?
  public var settingsFlowController: SettingsFlowControllerProtocol?
  
  init(with tabBarController: RootTabBarController) {
    self.tabBarController = tabBarController
    setup()
  }
  
  public func setup() {
    // home
    let homeViewController = HomeViewController()
    let homeNavigationController = UINavigationController(rootViewController: homeViewController)
    let homeFlowController = HomeFlowController(with: self, navigationController: homeNavigationController)
    homeViewController.flowController = homeFlowController
    homeNavigationController.tabBarItem = UITabBarItem.init(title: "Home", image: nil, selectedImage: nil)
    self.homeFlowController = homeFlowController
    
    // setttings
    let settingsVC = SettingsViewController()
    let settingsNC = UINavigationController(rootViewController: settingsVC)
    let settingsFC = SettingsFlowController(with: self, navigationController: settingsNC)
    settingsVC.flowController = settingsFC
    settingsNC.tabBarItem = UITabBarItem.init(title: "Settings", image: nil, selectedImage: nil)
    self.settingsFlowController = settingsFC
    
    // setup view controllers
    tabBarController.viewControllers = [homeNavigationController, settingsNC]
  }
  
  public func allGoBackToRoot(animated: Bool) -> Future {
    return Future.value(())
  }
  
  public func goToHomeSection() -> Future {
    return Future.value(())
  }
  
  public func goToSettingsSection() -> Future {
    return Future.value(())
  }
  
  
}
