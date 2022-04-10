//
//  LookDetailsCoordinator.swift
//  GetOutfit
//

import Foundation

class LookDetailsCoordinator: ConfigurableCoordinator {
  // MARK: - Properties
  
  let navigationController: NavigationController
  let appDependency: AppDependency
  
  var childCoordinators: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  private let look: Look
  
  // MARK: - Init
  
  required init(navigationController: NavigationController,
                appDependency: AppDependency, configuration: Look) {
    self.navigationController = navigationController
    self.appDependency = appDependency
    self.look = configuration
  }
  
  // MARK: - Navigation
  
  func start(animated: Bool) {
    let viewModel = LookDetailsViewModel(look: look, dependencies: appDependency)
    viewModel.delegate = self
    let viewController = LookDetailsViewController(viewModel: viewModel)
    viewController.hidesBottomBarWhenPushed = true
    addPopObserver(for: viewController)
    viewController.title = "Образ"
    navigationController.pushViewController(viewController, animated: animated)
  }
}

// MARK: - LookDetailsViewModelDelegate

extension LookDetailsCoordinator: LookDetailsViewModelDelegate {
  func lookDetailsViewModel(_ viewModel: LookDetailsViewModel, didSelect lookItem: LookItem) {
    show(ProductDetailsCoordinator.self, configuration: lookItem.id, animated: true)
  }
}
