//
//  ExerciseSceneBuilder.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class ExerciseSceneBuilder {
  
  static func make(with exercises: [Exercise]) -> ExerciseSceneViewController {
    let view = ExerciseSceneViewController()
    // TODO: Injections
    let router = ExerciseSceneRouter(view)
    let interactor = ExerciseSceneInteractor(exercises: exercises)
    let presenter = ExerciseScenePresenter(view, interactor: interactor, router: router)
    view.presenter = presenter
    return view
  }
}
