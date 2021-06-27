//
//  MainPresenterMock.swift
//  KaiaTests
//
//  Created by Gungor Basa on 6/27/21.
//

import XCTest
@testable import Kaia

final class MainPresenterMock: MainPresenterProtocol {
  var viewWillAppearCalled = false
  var sectionCount = 1
  var rowCount = 1

  var currentViewModel: ExerciseCellViewModel?
  var title: String = ""
  var tapLikeCalled = false
  var tapStartButtonCalled = false

  func onViewWillAppear() {
    viewWillAppearCalled = true
  }

  func numberOfSections() -> Int { sectionCount }

  func numberOfRows() -> Int { rowCount }

  func viewModel(for index: Int) -> ExerciseCellViewModel? { currentViewModel }

  func titleForHeader() -> String { title }

  func didTapLike(on index: Int) {
    tapLikeCalled = true
  }

  func didTapStartButton() {
    tapStartButtonCalled = true
  }
}
