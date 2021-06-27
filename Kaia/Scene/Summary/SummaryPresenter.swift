//
//  SummaryPresenter.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class SummaryPresenter: SummaryPresenterProtocol {

  private weak var view: SummaryViewProtocol?

  private let interactor: SummaryInteractorProtocol
  private let router: SummaryRouterProtocol
  private let factory: ExerciseCellViewModelFactoring

  init(
    _ view: SummaryViewProtocol,
    interactor: SummaryInteractorProtocol,
    router: SummaryRouterProtocol,
    factory: ExerciseCellViewModelFactoring
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
    self.factory = factory
    self.interactor.delegate = self
  }

  func numberOfSections() -> Int { 2 }
  func numberOfRows(in section: Int) -> Int {
    if section == 0 {
      return interactor.skippedExercises.count
    } else if section == 1 {
      return interactor.nonSkippedExercises.count
    } else {
      return 0
    }
  }

  func viewModel(for indexPath: IndexPath) -> ExerciseCellViewModel? {
    if indexPath.section == 0, interactor.skippedExercises.count < indexPath.row {
      let viewModel = factory.make(with: [interactor.skippedExercises[indexPath.row]]).first
      return viewModel
    } else if indexPath.section == 1, interactor.nonSkippedExercises.count < indexPath.row {
      return factory.make(with: [interactor.nonSkippedExercises[indexPath.row]]).first
    } else {
      return nil
    }
  }
  func titleForHeader(in section: Int) -> String {
    if section == 0 {
      return "Skipped Exercises"
    } else {
      return "Completed Exercises"
    }
  }
}

extension SummaryPresenter: SummaryInteractorDelegate {

  func handleOutput(_ output: SummaryInteractorOutput) {

  }
}
