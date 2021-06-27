//
//  ExerciseSceneRouter.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class ExerciseSceneRouter: ExerciseSceneRouterProtocol {
  
  weak var view: UIViewController?
  
  init(_ view: UIViewController) {
    self.view = view
  }
  
  func navigate(to route: ExerciseSceneRoute) {
    switch route {
    case .dismiss:
      view?.navigationController?.popViewController(animated: true)
    case .summary(let exercises, let skipList):
      view?.navigationController?.pushViewController(
        SummaryBuilder.make(exercises: exercises, skippedList: skipList),
        animated: true
      )
    }
  }
}
