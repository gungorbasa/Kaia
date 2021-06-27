//
//  ExerciseCellViewModel.swift
//  Kaia
//
//  Created by Gungor Basa on 6/27/21.
//

import Foundation

struct ExerciseCellViewModel: Codable {
  let id: Int
  let imageUrl: URL?
  let title: String
  let isFavorite: Bool
}
