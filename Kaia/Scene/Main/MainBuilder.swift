//
//  MainBuilder.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MainBuilder {
  
  static func make() -> MainViewController {
    let view = MainViewController()
    // TODO: Injections
    let router = MainRouter(view)
    let service = ExerciseService()
    let interactor = MainInteractor(service: service, storage: LocalUserDefaults())
    let presenter = MainPresenter(view, interactor: interactor, router: router)
    view.presenter = presenter
    return view
  }
}
