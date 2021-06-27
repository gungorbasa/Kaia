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
    presenter.onViewDidLoad()
  }
}

private extension MainViewController {
  func setup() {
    setupStackView()
    setupTableView()
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

  func setupTableView() {
    tableView.register(cell: ExerciseCell.self)
    tableView.dataSource = self
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

extension MainViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    presenter.numberOfSections()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    presenter.numberOfRows()
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(ExerciseCell.self, for: indexPath)
    guard let viewModel = presenter.viewModel(for: indexPath.row) else {
      return cell
    }
    cell.delegate = self
    cell.configure(with: viewModel)
    return cell
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    presenter.titleForHeader()
  }
}

extension MainViewController: ExerciseCellDelegate {
  func didTapFavoriteButton(on cell: ExerciseCell) {
    guard let indexPath = tableView.indexPath(for: cell) else { return }
    presenter.didTapLike(on: indexPath.row)
  }
}

extension MainViewController: MainViewProtocol {
  func handleOutput(_ output: MainPresenterOutput) {
    switch output {
    case .reload:
      tableView.reloadData()
    }
  }
}
