//
//  MainViewController.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SnapKit
import UIKit

final class MainViewController: UIViewController {
  
  var presenter: MainPresenterProtocol!

  private let tableView = UITableView.autolayoutView()
  private let startButton = UIButton.autolayoutView()
  private let stackView = UIStackView.autolayoutView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  

}

private extension MainViewController {
  func setup() {
    setupStackView()
    setupStartButton()
  }

  func setupStackView() {
    view.addSubview(stackView)
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.addArrangedSubview(tableView)
    stackView.addArrangedSubview(startButton)

    // For some reason snp doesnt work correctly with safe area at this place
    stackView.snp.makeConstraints {
      $0.edges.equalTo(view.safeAreaInsets)
    }
  }

  func setupStartButton() {
    startButton.setTitle("Start Exercises", for: .normal)
    startButton.backgroundColor = .blue
    startButton.setTitleColor(.white, for: .normal)
    startButton.addTarget(self, action: #selector(didButtonClick), for: .touchUpInside)
    startButton.snp.makeConstraints {
      $0.height.equalTo(66)
    }
  }

  @objc
  func didButtonClick() {
    print("Button Clicked")
  }
}

extension MainViewController: MainViewProtocol {
  
  func handleOutput(_ output: MainPresenterOutput) {
    
  }
}
