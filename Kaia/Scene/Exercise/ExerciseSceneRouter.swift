//
//  ExerciseSceneRouter.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class ExerciseSceneRouter: ExerciseSceneRouterProtocol {

    unowned let view: UIViewController

    init(_ view: UIViewController) {
        self.view = view
    }

    func navigate(to route: ExerciseSceneRoute) {
      switch route {
      case .dismiss:
        view.navigationController?.popViewController(animated: true)
      }
    }
}
