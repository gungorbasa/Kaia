//
//  ExerciseCellViewModelFactoryMock.swift
//  KaiaTests
//
//  Created by Gungor Basa on 6/27/21.
//

import XCTest
@testable import Kaia

final class ExerciseCellViewModelFactoryMock: ExerciseCellViewModelFactoring {
  var result: [ExerciseCellViewModel] = []
  var isMakeCalled = false

  func make(with models: [Exercise]) -> [ExerciseCellViewModel] {
    isMakeCalled = true
    return result
  }
}
