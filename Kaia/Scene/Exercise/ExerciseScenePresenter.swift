//
//  ExerciseScenePresenter.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class ExerciseScenePresenter: ExerciseScenePresenterProtocol {

    private unowned let view: ExerciseSceneViewProtocol

    private let interactor: ExerciseSceneInteractorProtocol
    private let router: ExerciseSceneRouterProtocol

    init(_ view: ExerciseSceneViewProtocol, interactor: ExerciseSceneInteractorProtocol, router: ExerciseSceneRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.interactor.delegate = self
    }
}

extension ExerciseScenePresenter: ExerciseSceneInteractorDelegate {

    func handleOutput(_ output: ExerciseSceneInteractorOutput) {

    }
}
