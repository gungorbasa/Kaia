//
//  ExerciseScenePresenter.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class ExerciseScenePresenter: ExerciseScenePresenterProtocol {
  private weak var view: ExerciseSceneViewProtocol?

  private let interactor: ExerciseSceneInteractorProtocol
  private let router: ExerciseSceneRouterProtocol
  private var currentExerciseIndex = 0
  private var skippedExerciseIds: [Int] = []

  var videoTitle: String {
    interactor.currentExercise()?.name ?? ""
  }

  init(_ view: ExerciseSceneViewProtocol, interactor: ExerciseSceneInteractorProtocol, router: ExerciseSceneRouterProtocol) {
    self.view = view
    self.interactor = interactor
    self.router = router
    self.interactor.delegate = self
  }

  func urlForPlayer() -> URL? {
    URL(string: interactor.currentExercise()?.videoURL ?? "")
  }

  func skipExercise() {
    interactor.skipExercise()
  }
}

extension ExerciseScenePresenter: ExerciseSceneInteractorDelegate {
  func handleOutput(_ output: ExerciseSceneInteractorOutput) {

  }
}
