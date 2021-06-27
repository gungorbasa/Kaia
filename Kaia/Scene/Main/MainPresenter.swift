//
//  MainPresenter.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class MainPresenter: MainPresenterProtocol {
  
  private weak var view: MainViewProtocol?
  
  private let interactor: MainInteractorProtocol
  private let router: MainRouterProtocol
  private let factory: ExerciseCellViewModelFactoring
  private var exercises: [ExerciseCellViewModel] = []
  
  init(_ view: MainViewProtocol, interactor: MainInteractorProtocol, router: MainRouterProtocol, factory: ExerciseCellViewModelFactoring) {
    self.view = view
    self.interactor = interactor
    self.router = router
    self.factory = factory
    self.interactor.delegate = self
  }

  func onViewWillAppear() {
    interactor.fetchExercises()
  }

  func numberOfSections() -> Int { 1 }
  func numberOfRows() -> Int { exercises.count }
  func viewModel(for index: Int) -> ExerciseCellViewModel? {
    guard index < exercises.count else { return nil }
    return exercises[index]
  }
  func titleForHeader() -> String { "Exercises" }

  func didTapLike(on index: Int) {
    guard index < exercises.count else { return }
    let exercise = exercises[index]
    interactor.exerciseLikeAction(exercise.id, isLiked: exercise.isFavorite)
    view?.handleOutput(.reload)
  }

  func didTapStartButton() {
    router.navigate(to: .exercise(interactor.exercises))
  }
}

extension MainPresenter: MainInteractorDelegate {
  func handleOutput(_ output: MainInteractorOutput) {
    switch output {
    case .list(let exercises):
      let localExercises = factory.make(with: exercises)
      DispatchQueue.main.async {
        self.exercises = localExercises
        self.view?.handleOutput(.reload)
      }
    case .error:
      DispatchQueue.main.async {
        self.router.navigate(to: .alert("Error", "Something unexpected occurred. Please, try again!"))
      }
    case .update(let index):
      exercises[index] = ExerciseCellViewModel(
        id: exercises[index].id,
        imageUrl: exercises[index].imageUrl,
        title: exercises[index].title,
        isFavorite: exercises[index].isFavorite ? false : true
      )
    }
  }
}
