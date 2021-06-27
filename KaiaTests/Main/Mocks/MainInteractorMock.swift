//
//  MainInteractorMock.swift
//  KaiaTests
//
//  Created by Gungor Basa on 6/27/21.
//

import XCTest
@testable import Kaia

final class MainInteractorMock: MainInteractorProtocol {
  var delegate: MainInteractorDelegate?
  var isFetched = false
  var isLikeCalled = false

  var exercises: [Exercise] = []

  func fetchExercises() {
    isFetched = true
  }

  func exerciseLikeAction(_ id: Int, isLiked: Bool) {
    isLikeCalled = true
  }
}
