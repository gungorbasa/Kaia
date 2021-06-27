//
//  Storage.swift
//  Kaia
//
//  Created by Gungor Basa on 6/27/21.
//

import Foundation

// TODO: This implementation only covers for user defaults, for the sake of being quick implemented this way
// In normal case LocalStorageProtocol should be able to use any of the provider such as CoreData, Realm etc.
// With this implementation its not possible
protocol LocalStorageKeysProtocol {
  var rawValue: String { get }
}

protocol LocalStorageProtocol {
  func value<T>(key: LocalStorageKeysProtocol) -> T? where T: Codable
  func write<T>(key: LocalStorageKeysProtocol, value: T?) where T: Codable
  func remove(key: LocalStorageKeysProtocol)
}

final class LocalUserDefaults: LocalStorageProtocol {
  private let defaults: UserDefaults
  private let decoder: JSONDecoder
  private let encoder: JSONEncoder

  init(defaults: UserDefaults = .standard, encoder: JSONEncoder = .init(), decoder: JSONDecoder = .init()) {
    self.defaults = defaults
    self.encoder = encoder
    self.decoder = decoder
  }

  func value<T>(key: LocalStorageKeysProtocol) -> T? where T: Codable {
    guard let data = defaults.object(forKey: key.rawValue) as? Data else {
      return nil
    }

    return try? decoder.decode(T.self, from: data)
  }

  func write<T>(key: LocalStorageKeysProtocol, value: T?) where T: Codable {
    let encoded = try? encoder.encode(value)
    defaults.set(encoded, forKey: key.rawValue)
  }

  func remove(key: LocalStorageKeysProtocol) {
    defaults.set(nil, forKey: key.rawValue)
  }
}
