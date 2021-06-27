//
//  MainViewMock.swift
//  KaiaTests
//
//  Created by Gungor Basa on 6/27/21.
//

import XCTest
@testable import Kaia

final class MainViewMock: MainViewProtocol {
  var presenterOutput: MainPresenterOutput?

  func handleOutput(_ output: MainPresenterOutput) {
    presenterOutput = output
  }
}
