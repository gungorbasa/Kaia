//
//  UIView+Extension.swift
//  Kaia
//
//  Created by Gungor Basa on 6/27/21.
//

import UIit

extension UIView {
  /// Initializes autolayout `view` instance
  class func autolayoutView() -> Self {
    let instance = self.init()
    instance.translatesAutoresizingMaskIntoConstraints = false
    return instance
  }

  /// Tranforms existing view into autolayout
  func autolayoutView() -> Self {
    translatesAutoresizingMaskIntoConstraints = false
    return self
  }
}
