//
//  MainRouter.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MainRouter: MainRouterProtocol {
  
  unowned let view: UIViewController
  
  init(_ view: UIViewController) {
    self.view = view
  }
  
  func navigate(to route: MainRoute) {
    
  }
}
