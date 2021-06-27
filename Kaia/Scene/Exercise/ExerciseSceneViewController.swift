//
//  ExerciseSceneViewController.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class ExerciseSceneViewController: UIViewController {

    var presenter: ExerciseScenePresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {

    }
}

extension ExerciseSceneViewController: ExerciseSceneViewProtocol {

    func handleOutput(_ output: ExerciseScenePresenterOutput) {

    }
}
