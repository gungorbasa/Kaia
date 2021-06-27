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
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let view = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
    // TODO: Injections
    let router = MainRouter(view)
    //        let networkWorker = NetworkWorker(app.networking)
    //        let service = RestaurantListService(networkWorker, database: DbWorker(Database()))
    //        //        MovieListInteractor(app.service)
    let interactor = MainInteractor()
    //        let interactor = MainInteractor(service)
    let presenter = MainPresenter(view, interactor: interactor, router: router)
    view.presenter = presenter
    return view
  }
}
