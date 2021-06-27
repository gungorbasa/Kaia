//
//  ExerciseSceneInteractor.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class ExerciseSceneInteractor: ExerciseSceneInteractorProtocol {
  weak var delegate: ExerciseSceneInteractorDelegate?
  private var currentExerciseCounter = 0
  private let exercises: [Exercise]

  init(exercises: [Exercise]) {
    self.exercises = exercises
  }

  func skipExercise() {
    currentExerciseCounter += 1
    if currentExerciseCounter >= exercises.count {
      delegate?.handleOutput(.finished(exercises))
    }
  }

  func currentExercise() -> Exercise? {
    guard exercises.count > currentExerciseCounter else { return nil }
    return exercises[currentExerciseCounter]
  }
}
