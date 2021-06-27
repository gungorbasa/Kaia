//
//  MainRouter.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MainRouter: MainRouterProtocol {
  weak var view: UIViewController?
  
  init(_ view: UIViewController) {
    self.view = view
  }
  
  func navigate(to route: MainRoute) {
      switch route {
      case .alert(let title, let message):
        showAlertView(title: title, message: message)
      }
    }
}

private extension MainRouter {
  func showAlertView(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    view?.present(alert, animated: true)
  }
}
