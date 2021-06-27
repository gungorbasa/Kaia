//
//  ExerciseService.swift
//  Kaia
//
//  Created by Gungor Basa on 6/27/21.
//

import Foundation
import Networking

protocol ExerciseServing {
  func fetch(completion: @escaping (Result<[ExerciseNetwork], Error>) -> Void)
}

final class ExerciseService: ExerciseServing {
  private let networking: Networking

  init(networking: Networking = NativeNetwork(decoder: JSONDecoder())) {
    self.networking = networking
  }

  func fetch(completion: @escaping (Result<[ExerciseNetwork], Error>) -> Void) {
    networking.run(ExerciseNetworkRoutes.list, completion: completion)
  }
}
