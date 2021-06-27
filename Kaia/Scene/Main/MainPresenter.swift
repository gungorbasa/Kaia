//
//  MainPresenter.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class MainPresenter: MainPresenterProtocol {
  
  private weak var view: MainViewProtocol?
  
  private let interactor: MainInteractorProtocol
  private let router: MainRouterProtocol
  
  init(_ view: MainViewProtocol, interactor: MainInteractorProtocol, router: MainRouterProtocol) {
    self.view = view
    self.interactor = interactor
    self.router = router
    self.interactor.delegate = self
  }

  func onViewDidLoad() {
    interactor.fetchExercises()
  }
}

extension MainPresenter: MainInteractorDelegate {
  
  func handleOutput(_ output: MainInteractorOutput) {
    
  }
}
