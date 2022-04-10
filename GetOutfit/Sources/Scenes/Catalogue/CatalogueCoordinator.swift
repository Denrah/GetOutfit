//
//  CatalogueCoordinator.swift
//  GetOutfit
//

import Foundation

class CatalogueCoordinator: Coordinator {
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
    let viewModel = CatalogueViewModel(dependencies: appDependency)
    viewModel.delegate = self
    let viewController = CatalogueViewController(viewModel: viewModel)
    addPopObserver(for: viewController)
    navigationController.pushViewController(viewController, animated: animated)
  }
  
  private func showProducts(category: Category) {
    let viewModel = CatalogueProductsViewModel(category: category, dependencies: appDependency)
    viewModel.delegate = self
    let viewController = CatalogueProductsViewController(viewModel: viewModel)
    viewController.hidesBottomBarWhenPushed = true
    navigationController.pushViewController(viewController, animated: true)
  }
  
  private func showProductDetails(product: Product) {
    show(ProductDetailsCoordinator.self, configuration: product.id, animated: true)
  }
}

// MARK: - CatalogueViewModelDelegate

extension CatalogueCoordinator: CatalogueViewModelDelegate {
  func catalogueViewModel(_ viewModel: CatalogueViewModel, didSelect category: Category) {
    showProducts(category: category)
  }
}

// MARK: - CatalogueProductsViewModelDelegate

extension CatalogueCoordinator: CatalogueProductsViewModelDelegate {
  func catalogueProductsViewModel(_ viewModel: CatalogueProductsViewModel,
                                  didSelect product: Product) {
    showProductDetails(product: product)
  }
}
