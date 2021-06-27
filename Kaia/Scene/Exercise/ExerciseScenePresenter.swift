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
  private var debouncer: Debouncing

  init(
    _ view: ExerciseSceneViewProtocol,
    interactor: ExerciseSceneInteractorProtocol,
    router: ExerciseSceneRouterProtocol,
    debouncer: Debouncing
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
    self.debouncer = debouncer
    self.interactor.delegate = self
    setup()
  }

  func onViewDidLoad() {
    guard let url = URL(string: interactor.currentExercise()?.videoURL ?? "") else { return }
    view?.handleOutput(.url(url))
    view?.handleOutput(.videoTitle(interactor.currentExercise()?.name ?? ""))
  }

  func onViewWillDisappear() {
    view?.handleOutput(.invalidatePlayer)
  }

  func skipExercise() {
    guard let exercise = interactor.currentExercise() else { return }
    skippedExerciseIds.append(exercise.id)
    nextExercise()
  }

  func nextExercise() {
    interactor.skipExercise()
    guard let url = URL(string: interactor.currentExercise()?.videoURL ?? "") else { return }
    view?.handleOutput(.url(url))
    view?.handleOutput(.videoTitle(interactor.currentExercise()?.name ?? ""))
    view?.showTitle()
    debouncer.renewInterval()
  }

  func onTouchCloseButton() {
    router.navigate(to: .dismiss)
  }

  private func setup() {
    debouncer.handler = { [weak self] in
      self?.view?.hideTitle()
    }
    debouncer.renewInterval()
  }
}

extension ExerciseScenePresenter: ExerciseSceneInteractorDelegate {
  func handleOutput(_ output: ExerciseSceneInteractorOutput) {
    switch output {
    case .finished(let exercises):
      router.navigate(to: .summary(exercises: exercises, skipList: skippedExerciseIds))
    }
  }
}
