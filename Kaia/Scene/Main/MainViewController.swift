//
//  MainViewController.swift
//  Kaia
//
//  Created Gungor Basa on 6/27/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
  
  var presenter: MainPresenterProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    
  }
}

extension MainViewController: MainViewProtocol {
  
  func handleOutput(_ output: MainPresenterOutput) {
    
  }
}
