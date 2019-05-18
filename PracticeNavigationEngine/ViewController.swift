//
//  ViewController.swift
//  PracticeNavigationEngine
//
//  Created by David on 2019/5/18.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let settings = DeepLinkSettings()
  var urlGateway: URLGateway?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    urlGateway = URLGateway(settings: settings)
    let url = URL(string: "roo://sajoij.com/settings/hello")!
    urlGateway?.handleURL(url)
      .done({ url in 
        print(url)
      })
      .catch({ e in 
        print(e)
      })
  }


}

