//
//  UITableView+Extension.swift
//  Kaia
//
//  Created by Gungor Basa on 6/27/21.
//

import UIKit

extension UITableView {
  /// Register given cell type
  func register<T: UITableViewCell>(cell: T.Type) {
    register(cell, forCellReuseIdentifier: T.identifier)
  }
  
  /// Dequeue reusable cell
  func dequeueReusableCell<T: UITableViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
      return T()
    }
    return cell
  }
  
  func layoutHeaderIfNeeded() {
    guard let headerView = tableHeaderView else {
      return
    }
    
    let sizeToFit = CGSize(width: frame.width,
                           height: CGFloat.greatestFiniteMagnitude)
    headerView.frame.size = headerView.systemLayoutSizeFitting(sizeToFit)
    headerView.layoutIfNeeded()
    tableHeaderView = headerView
  }
}
