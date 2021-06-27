//
//  ExerciseSceneContracts.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

// MARK: - Interactor
protocol ExerciseSceneInteractorProtocol: class {

    var delegate: ExerciseSceneInteractorDelegate? { get set }
}

enum ExerciseSceneInteractorOutput {

}

protocol ExerciseSceneInteractorDelegate: class {

    func handleOutput(_ output: ExerciseSceneInteractorOutput)
}

// MARK: - Presenter
protocol ExerciseScenePresenterProtocol: class {

}

enum ExerciseScenePresenterOutput: Equatable {

}

// MARK: - View
protocol ExerciseSceneViewProtocol: class {

    func handleOutput(_ output: ExerciseScenePresenterOutput)
}

// MARK: - Router
enum ExerciseSceneRoute: Equatable {

}

protocol ExerciseSceneRouterProtocol: class {

    func navigate(to route: ExerciseSceneRoute)
}
