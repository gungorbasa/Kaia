//
//  ExerciseCellViewModelFactory.swift
//  Kaia
//
//  Created by Gungor Basa on 6/27/21.
//

import Foundation

protocol ExerciseCellViewModelFactoring {
  func make(with models: [Exercise]) -> [ExerciseCellViewModel]
}

struct ExerciseCellViewModelFactory: ExerciseCellViewModelFactoring {
  func make(with models: [Exercise]) -> [ExerciseCellViewModel] {
    models.map { .init(imageUrl: URL(string: $0.coverImageURL), title: $0.name, isFavorite: $0.isFavorite) }
  }
}
