//
//  ExerciseSceneViewController.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import AVKit
import Combine
import UIKit

final class ExerciseSceneViewController: UIViewController {
  private let playerViewController = AVPlayerViewController()
  private let skipButton = UIButton.autolayoutView()
  private let titleLabel = UILabel.autolayoutView()
  private let closeButton = UIButton.autolayoutView()

  private var cancelBag: Set<AnyCancellable> = []

  private let titleAnimationDuration = 0.3

  var presenter: ExerciseScenePresenterProtocol!

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    presenter.onViewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: true)
  }

  func showTitle() {
    UIView.animate(withDuration: titleAnimationDuration) {
      self.titleLabel.alpha = 1.0
    }
  }

  func hideTitle() {
    UIView.animate(withDuration: titleAnimationDuration) {
      self.titleLabel.alpha = 0.0
    }
  }
}

extension ExerciseSceneViewController {
  private func setup() {
    setupCloseButton()
    setupAVPlayerViewController()
    setupSkipButton()
    setupTitleLabel()
  }

  func setupAVPlayerViewController() {
    addChild(playerViewController)
    view.addSubview(playerViewController.view)
    playerViewController.view.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    playerViewController.didMove(toParent: self)
    view.sendSubviewToBack(playerViewController.view)

    NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)
      .sink { [weak self] _ in
        self?.presenter.skipExercise()
      }
      .store(in: &cancelBag)
  }

  func setupCloseButton() {
    view.addSubview(closeButton)
    closeButton.setImage(Images.closeButton, for: .normal)
    closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
    closeButton.snp.makeConstraints {
      $0.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(36)
      $0.size.equalTo(44)
    }
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

  @objc
  func didTapClose() {
    presenter.onTouchCloseButton()
  }
}

extension ExerciseSceneViewController: ExerciseSceneViewProtocol {
  func handleOutput(_ output: ExerciseScenePresenterOutput) {
    switch output {
    case .url(let url):
      let player = AVPlayer(url: url)
      let playerFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
      playerViewController.view.frame = playerFrame
      playerViewController.player = player
      playerViewController.player?.play()
    case .videoTitle(let title):
      titleLabel.text = title
    }
  }
}
