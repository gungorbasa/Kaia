//
//  ExerciseSceneViewController.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import AVKit
import UIKit

final class ExerciseSceneViewController: UIViewController {
  private let playerViewController = AVPlayerViewController()
  private let skipButton = UIButton.autolayoutView()
  private let titleLabel = UILabel.autolayoutView()

  private let titleAnimationDuration = 0.3

  var presenter: ExerciseScenePresenterProtocol!

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  private func setup() {
    setupAVPlayerViewController()
    setupSkipButton()
    setupTitleLabel()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: true)
  }

  func showTitle() {
    func hideTitle() {
      UIView.animate(withDuration: titleAnimationDuration) {
        self.titleLabel.alpha = 1.0
      }
    }
  }

  func hideTitle() {
    UIView.animate(withDuration: titleAnimationDuration) {
      self.titleLabel.alpha = 0.0
    }
  }
}

extension ExerciseSceneViewController {
  func setupAVPlayerViewController() {
    guard let url = presenter.urlForPlayer() else { return }
    let player = AVPlayer(url: url)
    let playerFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)

    playerViewController.player = player
    playerViewController.view.frame = playerFrame

    addChild(playerViewController)
    view.addSubview(playerViewController.view)
    playerViewController.view.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    playerViewController.didMove(toParent: self)
    view.sendSubviewToBack(playerViewController.view)
  }

  func setupSkipButton() {
    view.addSubview(skipButton)
    skipButton.setTitle("Skip", for: .normal)
    skipButton.addTarget(self, action: #selector(didTapSkip), for: .touchUpInside)
    skipButton.backgroundColor = .black.withAlphaComponent(0.4)
    skipButton.setTitleColor(.white, for: .normal)
    skipButton.snp.makeConstraints { $0.height.equalTo(44) }
    skipButton.snp.makeConstraints {
      $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(8)
      $0.centerY.equalToSuperview()
    }
  }

  func setupTitleLabel() {
    view.addSubview(titleLabel)
    titleLabel.text = presenter.videoTitle
    titleLabel.backgroundColor = .black.withAlphaComponent(0.4)
    titleLabel.textColor = .white
    titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
    titleLabel.snp.makeConstraints {
      $0.leading.equalTo(view.safeAreaLayoutGuide).offset(8)
      $0.centerY.equalToSuperview()
    }
  }

  @objc
  func didTapSkip() {
    presenter.skipExercise()
  }
}

extension ExerciseSceneViewController: ExerciseSceneViewProtocol {
  func handleOutput(_ output: ExerciseScenePresenterOutput) {

  }
}
