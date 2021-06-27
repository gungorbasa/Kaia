//
//  UITableViewCell+Extension.swift
//  Kaia
//
//  Created by Gungor Basa on 6/27/21.
//

import UIKit

extension UITableViewCell {
  /// Returns cell's reuse identifier
  static var identifier: String {
    return String(describing: self)
  }
}
