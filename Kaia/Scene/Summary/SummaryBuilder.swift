//
//  SummaryBuilder.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class SummaryBuilder {
  
  static func make(exercises: [Exercise], skippedList: [Int]) -> SummaryViewController {
    let view = SummaryViewController()
    // TODO: Injections
    let router = SummaryRouter(view)
    let interactor = SummaryInteractor(exercises: exercises, skippedList: skippedList, storage: LocalUserDefaults())
    let presenter = SummaryPresenter(
      view,
      interactor: interactor,
      router: router,
      factory: ExerciseCellViewModelFactory()
    )
    view.presenter = presenter
    return view
  }
}
