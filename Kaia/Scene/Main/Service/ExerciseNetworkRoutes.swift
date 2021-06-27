//
//  ExerciseNetworkRoutes.swift
//  Kaia
//
//  Created by Gungor Basa on 6/27/21.
//

import Foundation
import Networking

enum ExerciseNetworkRoutes: Routing {
  case list

  var host: String { "https://jsonblob.com/api/jsonBlob/" }
  var path: String {
    switch self {
    case .list:
      return "027787de-c76e-11eb-ae0a-39a1b8479ec2"
    }
  }
  var headers: [String : String] { [:] }
  var parameters: [String : Any] { [:] }
  var body: [String : Any] { [:] }
  var method: HTTPMethod { .get }
}
