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
  let skippedExercises: [Exercise]
  let nonSkippedExercises: [Exercise]

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
    storage.write(key: Storage.favorites, value: favorites)
  }
}
