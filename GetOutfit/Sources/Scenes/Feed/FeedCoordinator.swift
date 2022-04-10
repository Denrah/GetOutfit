//
//  FeedCoordinator.swift
//  GetOutfit
//

import Foundation

class FeedCoordinator: Coordinator {
  // MARK: - Properties
  
  let navigationController: NavigationController
  let appDependency: AppDependency
  
  var childCoordinators: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  // MARK: - Init
  
  required init(navigationController: NavigationController, appDependency: AppDependency) {
    self.navigationController = navigationController
    self.appDependency = appDependency
  }
  
  // MARK: - Navigation
  
  func start(animated: Bool) {
    let viewModel = FeedViewModel(dependencies: appDependency)
    viewModel.delegate = self
    let viewController = FeedViewController(viewModel: viewModel)
    addPopObserver(for: viewController)
    navigationController.pushViewController(viewController, animated: animated)
  }
  
  private func showLookDetails(look: Look) {
    show(LookDetailsCoordinator.self, configuration: look, animated: true)
  }
  
  private func showSearchScreen() {
    show(SearchCoordinator.self, animated: true)
  }
}

// MARK: - FeedViewModelDelegate

extension FeedCoordinator: FeedViewModelDelegate {
  func feedViewModel(_ viewModel: FeedViewModel, didSelect look: Look) {
    showLookDetails(look: look)
  }
  
  func feedViewModelDidRequestToSearch(_ viewModel: FeedViewModel) {
    showSearchScreen()
  }
}
