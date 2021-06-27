//
//  Debouncer.swift
//  Kaia
//
//  Created by Gungor Basa on 6/27/21.
//

import Foundation

protocol Debouncing {
  typealias Handler = () -> Void

  var handler: Handler? { get set }
  
  func renewInterval()
}

final class Debouncer: Debouncing {
  private let timeInterval: TimeInterval
  private var timer: Timer?

  var handler: Handler?

  init(timeInterval: TimeInterval) {
    self.timeInterval = timeInterval
  }

  func renewInterval() {
    timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false, block: { [weak self] (timer) in
      self?.timeIntervalDidFinish(for: timer)
    })
  }

  @objc
  private func timeIntervalDidFinish(for timer: Timer) {
    guard timer.isValid else {
      return
    }

    handler?()
  }
}
