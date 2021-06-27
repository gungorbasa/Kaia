//
//  MainContracts.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

// MARK: - Interactor
protocol MainInteractorProtocol: AnyObject {
  var delegate: MainInteractorDelegate? { get set }

  func fetchExercises()
  func exerciseLikeAction(_ id: Int, isLiked: Bool)
}

enum MainInteractorOutput {
  case list([Exercise])
  case error(Error)
}

protocol MainInteractorDelegate: AnyObject {
  func handleOutput(_ output: MainInteractorOutput)
}

// MARK: - Presenter
protocol MainPresenterProtocol: AnyObject {
  func onViewDidLoad()
  func numberOfSections() -> Int
  func numberOfRows() -> Int
  func viewModel(for index: Int) -> ExerciseCellViewModel?
  func titleForHeader() -> String
  func didTapLike(on index: Int)
}

enum MainPresenterOutput: Equatable {
  case reload
}

// MARK: - View
protocol MainViewProtocol: AnyObject {
  func handleOutput(_ output: MainPresenterOutput)
}

// MARK: - Router
enum MainRoute: Equatable {
  case alert(String, String)
}

protocol MainRouterProtocol: AnyObject {
  func navigate(to route: MainRoute)
}
