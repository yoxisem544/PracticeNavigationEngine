//
//  SettingsViewController.swift
//  PracticeNavigationEngine
//
//  Created by David on 2019/5/24.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

final public class SettingsViewController: UIViewController {
  
  // MARK: - 📌 Constants
  
  // MARK: - 🔶 Properties
  var flowController: SettingsFlowController?
  
  // MARK: - 🎨 Style
  
  // MARK: - 🧩 Subviews
  
  // MARK: - 👆 Actions
  
  // MARK: - 🔨 Initialization
  public init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - 🖼 View Lifecycle
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    seutpUI()
  }
  
  public override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    // resize when frame has changed...
  }
  
  // MARK: - 🏗 UI
  private func seutpUI() {
    navigationItem.title = "Set something!!"
  }
  
  // MARK: - 🚌 Public Methods
  
  // MARK: - 🔒 Private Methods
  
  
}

// MARK: - 🧶 Extensions
