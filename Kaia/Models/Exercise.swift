//
//  Exercise.swift
//  Kaia
//
//  Created by Gungor Basa on 6/27/21.
//

import Foundation

struct Exercise: Codable, Equatable {
  let id: Int
  let name: String
  let coverImageURL: String
  let videoURL: String
  let isFavorite: Bool
}
