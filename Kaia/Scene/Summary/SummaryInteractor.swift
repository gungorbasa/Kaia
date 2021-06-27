//
//  SummaryInteractor.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class SummaryInteractor: SummaryInteractorProtocol {
  weak var delegate: SummaryInteractorDelegate?

  private let storage: LocalStorageProtocol
  var skippedExercises: [Exercise]
  var nonSkippedExercises: [Exercise]

  init(exercises: [Exercise], skippedList: [Int], storage: LocalStorageProtocol) {
    self.storage = storage
    skippedExercises = exercises.filter { skippedList.contains($0.id) }
    nonSkippedExercises = exercises.filter { skippedList.contains($0.id) == false }
  }

  func exerciseLikeAction(_ id: Int, isLiked: Bool) {
    var favorites: [Int] = storage.value(key: Storage.favorites) ?? []
    if isLiked {
      favorites.removeAll(where: { $0 == id })
    } else {
      favorites.append(id)
    }
    updateLocalExerciseState(with: id)

    storage.write(key: Storage.favorites, value: favorites)
    delegate?.handleOutput(.update)
  }

  private func updateLocalExerciseState(with id: Int) {
    if let index = skippedExercises.firstIndex(where: { $0.id == id }) {
      skippedExercises[index] = Exercise(
        id: skippedExercises[index].id,
        name: skippedExercises[index].name,
        coverImageURL: skippedExercises[index].coverImageURL,
        videoURL: skippedExercises[index].videoURL,
        isFavorite: skippedExercises[index].isFavorite ? false : true
      )
    } else if let index = nonSkippedExercises.firstIndex(where: { $0.id == id }) {
      nonSkippedExercises[index] = Exercise(
        id: nonSkippedExercises[index].id,
        name: nonSkippedExercises[index].name,
        coverImageURL: nonSkippedExercises[index].coverImageURL,
        videoURL: nonSkippedExercises[index].videoURL,
        isFavorite: nonSkippedExercises[index].isFavorite ? false : true
      )
    }
  }
}
