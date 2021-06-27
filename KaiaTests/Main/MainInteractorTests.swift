//
//  MainInteractorTests.swift
//  KaiaTests
//
//  Created by Gungor Basa on 6/27/21.
//

import XCTest
@testable import Kaia

final class MainInteractorTests: XCTestCase {
  private var service: ExerciseServiceMock!
  private var storage: StorageMock<[Int]>!
  private var interactor: MainInteractor!

  override func setUpWithError() throws {
    service = ExerciseServiceMock()
    storage = StorageMock<[Int]>()
    interactor = MainInteractor(service: service, storage: storage)
  }

  func testFetchExercises() {
    XCTAssertFalse(service.isFetched, "Wrong initial state")
    XCTAssertFalse(storage.isValueCalled, "Wrong initial state")

    interactor.fetchExercises()

    XCTAssertTrue(service.isFetched, "Wrong initial state")
    XCTAssertTrue(storage.isValueCalled, "Wrong initial state")
  }

  func testLikeAction() {
    let exercises: [Exercise] = [
      .init(id: 1, name: "One", coverImageURL: "", videoURL: "", isFavorite: false),
      .init(id: 2, name: "Two", coverImageURL: "", videoURL: "", isFavorite: false)
    ]
    storage.storageValue = []

    XCTAssertFalse(storage.isValueCalled, "Wrong initial state")
    XCTAssertFalse(storage.isWriteCalled, "Wrong initial state")

    interactor.exerciseLikeAction(exercises[0].id, isLiked: exercises[0].isFavorite)

    XCTAssert(storage.writtenData?.first == 1)
    XCTAssertTrue(storage.isValueCalled, "Should call value")
    XCTAssertTrue(storage.isWriteCalled, "Should call write")
  }

  func testUnlikeAction() {
    let exercises: [Exercise] = [
      .init(id: 1, name: "One", coverImageURL: "", videoURL: "", isFavorite: true),
      .init(id: 2, name: "Two", coverImageURL: "", videoURL: "", isFavorite: false)
    ]
    storage.storageValue = [1]
    XCTAssertFalse(storage.isValueCalled, "Wrong initial state")
    XCTAssertFalse(storage.isWriteCalled, "Wrong initial state")

    interactor.exerciseLikeAction(exercises[0].id, isLiked: exercises[0].isFavorite)

    XCTAssert(storage.writtenData == [])
    XCTAssertTrue(storage.isValueCalled, "Should call value")
    XCTAssertTrue(storage.isWriteCalled, "Should call write")
  }
}
