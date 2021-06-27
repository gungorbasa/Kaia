//
//  MainInteractorTests.swift
//  KaiaTests
//
//  Created by Gungor Basa on 6/27/21.
//

import XCTest
@testable import Kaia

final class MainViewTests: XCTestCase {
  private var view: MainViewController!
  private var presenter: MainPresenterMock!

  func makeSUT() -> MainViewController {
    let sut = MainViewController()
    presenter = MainPresenterMock()
    sut.presenter = presenter
    sut.loadViewIfNeeded()
    return sut
  }

  override func setUpWithError() throws {
    view = makeSUT()
  }

  func testOnViewWillAppear() {
    XCTAssertFalse(presenter.viewWillAppearCalled, "Wrong initial state")
    view.viewWillAppear(false)
    XCTAssertTrue(presenter.viewWillAppearCalled, "Should call viewWillAppear on presenter")
  }

  func testNumberOfSections() {
    presenter.sectionCount = 10
    let result = view.numberOfSections(in: UITableView())
    XCTAssert(result == 10, "Should have 10 sections")
  }

  func testNumberOfRows() {
    presenter.rowCount = 100
    let result = view.tableView(UITableView(), numberOfRowsInSection: 1)
    XCTAssert(result == 100, "Should have 100 rows")
  }
}
