//
//  MainRouterMock.swift
//  KaiaTests
//
//  Created by Gungor Basa on 6/27/21.
//

import XCTest
@testable import Kaia

final class MainRouterMock: MainRouterProtocol {
  var route: MainRoute?

  func navigate(to route: MainRoute) {
    self.route = route
  }
}
