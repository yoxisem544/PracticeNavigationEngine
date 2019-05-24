//
//  RootTabBarController.swift
//  PracticeNavigationEngine
//
//  Created by David on 2019/5/24.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

public final class RootTabBarController: UITabBarController {
  
  var flowController: RootFlowController?
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
  }
  
}
