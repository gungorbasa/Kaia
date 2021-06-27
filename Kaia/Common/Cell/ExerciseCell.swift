//
//  ExerciseCell.swift
//  Kaia
//
//  Created by Gungor Basa on 6/27/21.
//

import Nuke
import UIKit

protocol ExerciseCellDelegate: AnyObject {
  func didTapFavoriteButton()
}

final class ExerciseCell: UITableViewCell {
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
    setupStackView()
    setupImage()
    setupFavoriteButton()
  }

  func setupStackView() {
    contentView.addSubview(stackView)
    stackView.axis = .horizontal
    stackView.addArrangedSubview(image)
    stackView.addArrangedSubview(name)

    stackView.snp.makeConstraints {
      $0.leading.equalTo(16)
      $0.top.bottom.equalTo(8)
    }
  }

  func setupImage() {
    image.snp.makeConstraints {
      $0.height.equalTo(80)
      $0.width.equalTo(120)
    }
  }

  func setupFavoriteButton() {
    contentView.addSubview(favoriteButton)
    favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
    favoriteButton.snp.makeConstraints {
      $0.size.equalTo(44)
      $0.leading.equalTo(stackView.snp.trailing).offset(8)
      $0.trailing.equalToSuperview().offset(16)
      $0.centerY.equalToSuperview()
    }
  }

  @objc
  func didTapFavoriteButton() {
    delegate?.didTapFavoriteButton()
  }
}
