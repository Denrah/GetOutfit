//
//  MainCoordinator.swift
//  GetOutfit
//

import UIKit

class MainCoordinator: Coordinator {
  var childCoordinators: [Coordinator] = []
  var onDidFinish: (() -> Void)?

  let navigationController: NavigationController
  let appDependency: AppDependency
  
  required init(navigationController: NavigationController, appDependency: AppDependency) {
    self.navigationController = navigationController
    self.appDependency = appDependency
  }

  func start(animated: Bool) {
    showTabBar(animated: animated)
    loadCategories()
  }

  private func showTabBar(animated: Bool) {
    show(TabBarCoordinator.self, animated: animated)
  }
  
  private func loadCategories() {
    Task {
      do {
        let categories = try await appDependency.networkService.getCategories()
        appDependency.userDataStore.categories = categories
      } catch {
        
      }
    }
    
  }
}
