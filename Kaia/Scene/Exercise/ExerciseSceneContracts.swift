//
//  ExerciseSceneContracts.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

// MARK: - Interactor
protocol ExerciseSceneInteractorProtocol: AnyObject {
  var delegate: ExerciseSceneInteractorDelegate? { get set }

  func currentExercise() -> Exercise?
  func skipExercise()
}

enum ExerciseSceneInteractorOutput {
  case finished([Exercise])
}

protocol ExerciseSceneInteractorDelegate: AnyObject {

  func handleOutput(_ output: ExerciseSceneInteractorOutput)
}

// MARK: - Presenter
protocol ExerciseScenePresenterProtocol: AnyObject {
  func onViewDidLoad()
  func onViewWillDisappear()
  func skipExercise()
  func nextExercise()
  func onTouchCloseButton()
}

enum ExerciseScenePresenterOutput: Equatable {
  case url(URL)
  case videoTitle(String)
  case invalidatePlayer
}

// MARK: - View
protocol ExerciseSceneViewProtocol: AnyObject {
  func handleOutput(_ output: ExerciseScenePresenterOutput)
  func showTitle()
  func hideTitle()
}

// MARK: - Router
enum ExerciseSceneRoute: Equatable {
  case dismiss
  case summary(exercises: [Exercise], skipList: [Int])
}

protocol ExerciseSceneRouterProtocol: AnyObject {

  func navigate(to route: ExerciseSceneRoute)
}
