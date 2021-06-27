//
//  ExerciseCell.swift
//  Kaia
//
//  Created by Gungor Basa on 6/27/21.
//

import Nuke
import UIKit

protocol ExerciseCellDelegate: AnyObject {
  func didTapFavoriteButton(on cell: ExerciseCell)
}

final class ExerciseCell: UITableViewCell {
  private let containerStackView = UIStackView.autolayoutView()
  private let stackView = UIStackView.autolayoutView()
  private let image = UIImageView.autolayoutView()
  private let name = UILabel.autolayoutView()
  private let favoriteButton = UIButton.autolayoutView()

  weak var delegate: ExerciseCellDelegate?

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    setup()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with viewModel: ExerciseCellViewModel) {
    Nuke.loadImage(with: viewModel.imageUrl, into: image)
    name.text = viewModel.title
    let buttonImage = viewModel.isFavorite ? Images.favoriteImage : Images.notFavoriteImage
    favoriteButton.setImage(buttonImage, for: .normal)
  }
}

private extension ExerciseCell {
  func setup() {
    setupContainerStackView()
    setupStackView()
    setupImage()
    setupFavoriteButton()
  }

  func setupContainerStackView() {
    contentView.addSubview(containerStackView)

    containerStackView.addArrangedSubview(stackView)
    containerStackView.addArrangedSubview(favoriteButton)

    containerStackView.axis = .horizontal
    containerStackView.alignment = .center
    containerStackView.distribution = .fill
    containerStackView.snp.makeConstraints {
      $0.edges.equalTo(contentView.safeAreaInsets)
    }
  }

  func setupStackView() {
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.addArrangedSubview(image)
    stackView.addArrangedSubview(name)
    stackView.spacing = 8
    stackView.snp.makeConstraints { $0.height.equalTo(80) }
  }

  func setupImage() {
    image.contentMode = .scaleAspectFill
    image.layer.masksToBounds = true
    image.snp.makeConstraints {
      $0.height.equalTo(80)
      $0.width.equalTo(120)
    }
  }

  func setupFavoriteButton() {
    favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
    favoriteButton.snp.makeConstraints {
      $0.size.equalTo(44)
    }
  }

  @objc
  func didTapFavoriteButton() {
    delegate?.didTapFavoriteButton(on: self)
  }
}
