//
//  MainContracts.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

// MARK: - Interactor
protocol MainInteractorProtocol: AnyObject {
  var delegate: MainInteractorDelegate? { get set }

  func fetchExercises()
}

enum MainInteractorOutput {
  case list([Exercise])
  case error(Error)
}

protocol MainInteractorDelegate: AnyObject {
  func handleOutput(_ output: MainInteractorOutput)
}

// MARK: - Presenter
protocol MainPresenterProtocol: AnyObject {
  func onViewDidLoad()
}

enum MainPresenterOutput: Equatable {
}

// MARK: - View
protocol MainViewProtocol: AnyObject {
  func handleOutput(_ output: MainPresenterOutput)
}

// MARK: - Router
enum MainRoute: Equatable {
}

protocol MainRouterProtocol: AnyObject {
  func navigate(to route: MainRoute)
}
