//
//  ProductDetailsCoordinator.swift
//  GetOutfit
//

import Foundation

class ProductDetailsCoordinator: ConfigurableCoordinator {
  // MARK: - Properties
  
  let navigationController: NavigationController
  let appDependency: AppDependency
  
  var childCoordinators: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  private let productID: String
  
  // MARK: - Init
  
  required init(navigationController: NavigationController,
                appDependency: AppDependency, configuration: String) {
    self.navigationController = navigationController
    self.appDependency = appDependency
    self.productID = configuration
  }
  
  // MARK: - Navigation
  
  func start(animated: Bool) {
    let viewModel = ProductDetailsViewModel(productID: productID, dependencies: appDependency)
    let viewController = ProductDetailsViewController(viewModel: viewModel)
    addPopObserver(for: viewController)
    viewController.hidesBottomBarWhenPushed = true
    navigationController.pushViewController(viewController, animated: animated)
  }
}
