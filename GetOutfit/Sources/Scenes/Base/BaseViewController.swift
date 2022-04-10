//
//  BaseViewController.swift
//  GetOutfit
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    view.backgroundColor = .white
  }
}
