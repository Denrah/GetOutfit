//
//  NewLookCoordinator.swift
//  GetOutfit
//

import Foundation
import UIKit

protocol NewLookCoordinatorDelegate: AnyObject {
  func newLookCoordinatorDidFinish(_ coordinator: NewLookCoordinator)
}

class NewLookCoordinator: Coordinator {
  // MARK: - Properties
  
  weak var delegate: NewLookCoordinatorDelegate?
  
  let navigationController: NavigationController
  let appDependency: AppDependency
  
  var childCoordinators: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  private let modalNavigationController = NavigationController()
  
  // MARK: - Init
  
  required init(navigationController: NavigationController,
                appDependency: AppDependency) {
    self.navigationController = navigationController
    self.appDependency = appDependency
  }
  
  // MARK: - Navigation
  
  func start(animated: Bool) {
    showGenderScreen(animated: animated)
  }
  
  private func showGenderScreen(animated: Bool) {
    let viewModel = NewLookGenderViewModel()
    viewModel.delegate = self
    let viewController = NewLookGenderViewController(viewModel: viewModel)
    viewController.title = "Подобрать образ"
    viewController.navigationItem.rightBarButtonItem = makeCloseButton()
    modalNavigationController.pushViewController(viewController, animated: false)
    modalNavigationController.modalPresentationStyle = .overFullScreen
    navigationController.present(modalNavigationController, animated: animated)
  }
  
  private func showStyleScreen(gender: Gender) {
    let viewModel = NewLookStyleViewModel(gender: gender, dependencies: appDependency)
    viewModel.delegate = self
    let viewController = NewLookStyleViewController(viewModel: viewModel)
    viewController.title = "Подобрать образ"
    viewController.navigationItem.rightBarButtonItem = makeCloseButton()
    modalNavigationController.pushViewController(viewController, animated: true)
  }
  
  private func showConstructorScreen(occasion: Occasion) {
    let viewModel = NewLookConstructorViewModel(occasion: occasion, dependencies: appDependency)
    viewModel.delegate = self
    let viewController = NewLookConstructorViewController(viewModel: viewModel)
    viewController.title = "Подобрать образ"
    viewController.navigationItem.rightBarButtonItem = makeCloseButton()
    modalNavigationController.pushViewController(viewController, animated: true)
  }
  
  private func showProductsScreen(products: [Product]) {
    let viewModel = NewLookProductsViewModel(products: products)
    viewModel.delegate = self
    let viewController = NewLookProductsViewController(viewModel: viewModel)
    viewController.title = "Подобрать образ"
    viewController.navigationItem.rightBarButtonItem = makeCloseButton()
    modalNavigationController.pushViewController(viewController, animated: true)
  }
  
  // MARK: - Private methods
  
  private func makeCloseButton() -> UIBarButtonItem {
    return UIBarButtonItem(image: UIImage(.close), style: .plain,
                           target: self, action: #selector(closeModal))
  }
  
  @objc private func closeModal() {
    navigationController.dismiss(animated: true)
    onDidFinish?()
  }
}

// MARK: - NewLookGenderViewModelDelegate

extension NewLookCoordinator: NewLookGenderViewModelDelegate {
  func newLookGenderViewModel(_ viewModel: NewLookGenderViewModel,
                              didSelect gender: Gender) {
    showStyleScreen(gender: gender)
  }
}

// MARK: - NewLookStyleViewModelDelegate

extension NewLookCoordinator: NewLookStyleViewModelDelegate {
  func newLookStyleViewModel(_ viewModel: NewLookStyleViewModel,
                             didSelect occasion: Occasion) {
    showConstructorScreen(occasion: occasion)
  }
}

// MARK: - NewLookConstructorViewModelDelegate

extension NewLookCoordinator: NewLookConstructorViewModelDelegate {
  func newLookConstructorViewModel(_ viewModel: NewLookConstructorViewModel,
                                   didSelect products: [Product]) {
    showProductsScreen(products: products)
  }
}

// MARK: - NewLookProductsViewModelDelegate

extension NewLookCoordinator: NewLookProductsViewModelDelegate {
  func newLookProductsViewModelDidFinish(_ viewModel: NewLookProductsViewModel) {
    delegate?.newLookCoordinatorDidFinish(self)
  }
}
