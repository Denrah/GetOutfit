//
//  SearchCoordinator.swift
//  GetOutfit
//

import Foundation

class SearchCoordinator: Coordinator {
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
    let viewModel = SearchViewModel(dependencies: appDependency)
    viewModel.delegate = self
    let viewController = SearchViewController(viewModel: viewModel)
    viewController.hidesBottomBarWhenPushed = true
    navigationController.pushViewController(viewController, animated: true)
  }
  
  private func showProductDetails(product: Product) {
    show(ProductDetailsCoordinator.self, configuration: product.id, animated: true)
  }
}

// MARK: - SearchViewModelDelegate

extension SearchCoordinator: SearchViewModelDelegate {
  func searchViewModel(_ viewModel: SearchViewModel, didSelect product: Product) {
    showProductDetails(product: product)
  }
}
