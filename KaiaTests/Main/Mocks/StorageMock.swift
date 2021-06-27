//
//  StorageMock.swift
//  KaiaTests
//
//  Created by Gungor Basa on 6/27/21.
//

import XCTest
@testable import Kaia

final class StorageMock<P>: LocalStorageProtocol {
  var isValueCalled = false
  var isWriteCalled = false
  var isRemoveCalled = false

  var storageValue: P?
  var writtenData: P?

  func value<T>(key: LocalStorageKeysProtocol) -> T? where T : Decodable, T : Encodable {
    isValueCalled = true
    return storageValue as? T
  }

  func write<T>(key: LocalStorageKeysProtocol, value: T?) where T : Decodable, T : Encodable {
    isWriteCalled = true
    writtenData = value as? P
  }

  func remove(key: LocalStorageKeysProtocol) {
    isRemoveCalled = true
  }
}
