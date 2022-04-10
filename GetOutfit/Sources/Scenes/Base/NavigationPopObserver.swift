//
//  NavigationPopObserver.swift
//  TSUInTime
//

import UIKit

class NavigationPopObserver {
  let observedViewController: UIViewController

  private let coordinator: Coordinator

  init(observedViewController: UIViewController, coordinator: Coordinator) {
    self.observedViewController = observedViewController
    self.coordinator = coordinator
  }

  func didObservePop() {
    coordinator.onDidFinish?()
  }
}
