//
//  SummaryContracts.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

// MARK: - Interactor
protocol SummaryInteractorProtocol: AnyObject {

  var delegate: SummaryInteractorDelegate? { get set }
  var skippedExercises: [Exercise] { get }
  var nonSkippedExercises: [Exercise] { get }

  func exerciseLikeAction(_ id: Int, isLiked: Bool)
}

enum SummaryInteractorOutput {
  case update
}

protocol SummaryInteractorDelegate: AnyObject {

  func handleOutput(_ output: SummaryInteractorOutput)
}

// MARK: - Presenter
protocol SummaryPresenterProtocol: AnyObject {
  func onViewDidLoad()
  func numberOfSections() -> Int
  func numberOfRows(in section: Int) -> Int
  func viewModel(for indexPath: IndexPath) -> ExerciseCellViewModel?
  func titleForHeader(in section: Int) -> String
  func onTapFinishExercise()
  func onTapLike(on indexPath: IndexPath)
}

enum SummaryPresenterOutput: Equatable {
  case reload
}

// MARK: - View
protocol SummaryViewProtocol: AnyObject {

  func handleOutput(_ output: SummaryPresenterOutput)
}

// MARK: - Router
enum SummaryRoute: Equatable {
  case dismiss
}

protocol SummaryRouterProtocol: AnyObject {

  func navigate(to route: SummaryRoute)
}
