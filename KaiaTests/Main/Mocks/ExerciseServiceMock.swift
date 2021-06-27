//
//  ExerciseServiceMock.swift
//  KaiaTests
//
//  Created by Gungor Basa on 6/27/21.
//

import XCTest
@testable import Kaia

final class ExerciseServiceMock: ExerciseServing {
  var isFetched = false

  func fetch(completion: @escaping (Result<[ExerciseNetwork], Error>) -> Void) {
    isFetched = true
  }
}
