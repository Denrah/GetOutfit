//
//  ConfigurableCoordinator.swift
//  GetOutfit
//

import Foundation

protocol ConfigurableCoordinator: Coordinator {
  associatedtype Configuration

  init(navigationController: NavigationController,
       appDependency: AppDependency, configuration: Configuration)
}

extension ConfigurableCoordinator {
  init(navigationController: NavigationController, appDependency: AppDependency) {
    fatalError("Use init with configuration for this coordinator")
  }
}
