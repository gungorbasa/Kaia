//
//  MainInteractor.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class MainInteractor: MainInteractorProtocol {
  weak var delegate: MainInteractorDelegate?

  private let service: ExerciseServing
  private let storage: LocalStorageProtocol

  init(service: ExerciseServing, storage: LocalStorageProtocol) {
    self.service = service
    self.storage = storage
  }

  func fetchExercises() {
    // MARK: Should be very quick, for big data this should be handled in another thread
    let favorites: [Int] = storage.value(key: Storage.favorites) ?? []
    service.fetch { [weak self] result in
      switch result {
      case .success(let exercises):
        let result: [Exercise] = exercises.map {
          Exercise(
            id: $0.id,
            name: $0.name,
            coverImageURL: $0.coverImageURL,
            videoURL: $0.videoURL,
            isFavorite: favorites.contains($0.id) ? true : false
          )
        }
        self?.delegate?.handleOutput(.list(result))
      case .failure(let error):
        self?.delegate?.handleOutput(.error(error))
      }
    }
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
