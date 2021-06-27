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

  func onViewDidLoad() {
    interactor.fetchExercises()
  }

  func numberOfSections() -> Int { 1 }
  func numberOfRows() -> Int { exercises.count }
  func viewModel(for index: Int) -> ExerciseCellViewModel? {
    guard index < exercises.count else { return nil }
    return exercises[index]
  }
  func titleForHeader() -> String {
    "Exercises"
  }

  func didTapLike(on index: Int) {
    guard index < exercises.count else { return }
    let exercise = exercises[index]
    interactor.exerciseLikeAction(exercise.id, isLiked: exercise.isFavorite)
    exercises[index] = ExerciseCellViewModel(
      id: exercise.id,
      imageUrl: exercise.imageUrl,
      title: exercise.title,
      isFavorite: exercise.isFavorite ? false : true
    )
    view?.handleOutput(.reload)
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
    }
  }
}
