//
//  SummaryViewController.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class SummaryViewController: UIViewController {
  
  var presenter: SummaryPresenterProtocol!

  private let stackView = UIStackView.autolayoutView()
  private let finishExercisesButton = UIButton.autolayoutView()
  private let tableView = UITableView.autolayoutView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    presenter.onViewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
}

extension SummaryViewController {
  func setup() {
    setupStackView()
    setupTableView()
    setupFinishExercisesButton()
  }

  func setupStackView() {
    view.addSubview(stackView)
    stackView.axis = .vertical
    stackView.addArrangedSubview(tableView)
    stackView.addArrangedSubview(finishExercisesButton)

    stackView.snp.makeConstraints {
      $0.top.bottom.trailing.leading.equalTo(view.safeAreaLayoutGuide)
    }
  }

  func setupTableView() {
    tableView.dataSource = self
    tableView.register(cell: ExerciseCell.self)
  }

  func setupFinishExercisesButton() {
    finishExercisesButton.backgroundColor = .blue
    finishExercisesButton.setTitleColor(.white, for: .normal)
    finishExercisesButton.setTitle("Finish Exercises", for: .normal)
    finishExercisesButton.snp.makeConstraints { $0.height.equalTo(44) }
    finishExercisesButton.addTarget(self, action: #selector(didTapFinishExerciseButton), for: .touchUpInside)
  }

  @objc
  func didTapFinishExerciseButton() {
    presenter.onTapFinishExercise()
  }
}

extension SummaryViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    presenter.numberOfSections()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    presenter.numberOfRows(in: section)
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    presenter.titleForHeader(in: section)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(ExerciseCell.self, for: indexPath)
    guard let viewModel = presenter.viewModel(for: indexPath) else {
      return cell
    }
    cell.delegate = self
    cell.configure(with: viewModel)
    return cell
  }
}

extension SummaryViewController: ExerciseCellDelegate {
  func didTapFavoriteButton(on cell: ExerciseCell) {
    guard let indexPath = tableView.indexPath(for: cell) else { return }
    presenter.onTapLike(on: indexPath)
  }
}

extension SummaryViewController: SummaryViewProtocol {
  func handleOutput(_ output: SummaryPresenterOutput) {
    switch output {
    case .reload:
      tableView.reloadData()
    }
  }
}
