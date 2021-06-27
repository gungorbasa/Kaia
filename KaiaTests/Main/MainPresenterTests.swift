//
//  MainInteractorTests.swift
//  KaiaTests
//
//  Created by Gungor Basa on 6/27/21.
//

import XCTest
@testable import Kaia

final class MainPresenterTests: XCTestCase {
  private var interactor: MainInteractorMock!
  private var view: MainViewMock!
  private var router: MainRouterMock!
  private var factory: ExerciseCellViewModelFactoryMock!
  private var presenter: MainPresenter!

  override func setUpWithError() throws {
    interactor = MainInteractorMock()
    view = MainViewMock()
    router = MainRouterMock()
    factory = ExerciseCellViewModelFactoryMock()


    presenter = MainPresenter(view, interactor: interactor, router: router, factory: factory)
    interactor.delegate = presenter
  }

  func testOnViewWillAppear() {
    XCTAssertFalse(interactor.isFetched, "Wrong initial state")
    presenter.onViewWillAppear()
    XCTAssertTrue(interactor.isFetched, "Should call fetch")
  }

  func testDidTapStartButton() {
    XCTAssertNil(router.route, "Wrong initial state")
    presenter.didTapStartButton()
    XCTAssertTrue(router.route == .exercise(interactor.exercises), "Should go to exercises screen with correct exercises")
  }

  func testNumberOfSections() {
    XCTAssert(presenter.numberOfSections() == 1, "Should have only 1 section")
  }

  func testNumberOfRows() {
    factory.result = [
      .init(id: 1, imageUrl: URL(string: ""), title: "One", isFavorite: true),
      .init(id: 2, imageUrl: URL(string: ""), title: "Two", isFavorite: true)
    ]
    presenter.handleOutput(.list([]))
    let expectation = self.expectation(description: "DispatchQueu.main.testNumberOfRows")
    DispatchQueue.main.async {
      expectation.fulfill()
    }
    waitForExpectations(timeout: 1, handler: nil)
    XCTAssert(presenter.numberOfRows() == factory.result.count, "Should be same with exercises.count")
  }

  func testViewModelFor() {
    factory.result = [
      .init(id: 1, imageUrl: URL(string: ""), title: "One", isFavorite: true),
      .init(id: 2, imageUrl: URL(string: ""), title: "Two", isFavorite: true)
    ]
    presenter.handleOutput(.list([]))
    let expectation = self.expectation(description: "DispatchQueu.main.testViewModelFor")
    DispatchQueue.main.async {
      expectation.fulfill()
    }
    waitForExpectations(timeout: 1, handler: nil)
    XCTAssert(presenter.viewModel(for: 0) == factory.result[0])
  }

  func testTitleForHeader() {
    XCTAssertTrue(presenter.titleForHeader() == "Exercises", "Title should be Exercises")
  }

  func testDidTapLike() {
    factory.result = [
      .init(id: 1, imageUrl: URL(string: ""), title: "One", isFavorite: true),
      .init(id: 2, imageUrl: URL(string: ""), title: "Two", isFavorite: true)
    ]
    presenter.handleOutput(.list([]))
    let expectation = self.expectation(description: "DispatchQueu.main.testViewModelFor")
    DispatchQueue.main.async {
      expectation.fulfill()
    }
    waitForExpectations(timeout: 1, handler: nil)
    presenter.didTapLike(on: 0)

    XCTAssertTrue(interactor.isLikeCalled, "Should call interactor like action")
    XCTAssertTrue(view.presenterOutput == .reload, "Should call reload")
  }
}
