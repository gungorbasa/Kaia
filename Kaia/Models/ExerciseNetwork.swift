//
//  Exercise.swift
//  Kaia
//
//  Created by Gungor Basa on 6/27/21.
//

import Foundation

struct ExerciseNetwork: Codable {
  let id: Int
  let name: String
  let coverImageURL: String
  let videoURL: String

  enum CodingKeys: String, CodingKey {
    case id, name
    case coverImageURL = "cover_image_url"
    case videoURL = "video_url"
  }
}
