//
//  TabBarCoordinator.swift
//  GetOutfit
//

import UIKit

class TabBarCoordinator: Coordinator {
  // NARK: - Properties
  
  var childCoordinators: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: NavigationController
  let appDependency: AppDependency
  
  private var tabCoordinators: [TabBarTabKind: Coordinator] = [:]
  private var navigationObserver: NavigationPopObserver?
  
  // MARK: - Init
  
  required init(navigationController: NavigationController, appDependency: AppDependency) {
    self.navigationController = navigationController
    self.appDependency = appDependency
  }
  
  // MARK: - Navigation
  
  func start(animated: Bool) {
    showTabBar(animated: animated)
  }
  
  private func showTabBar(animated: Bool) {
    let tabBarController = TabBarController()
    addPopObserver(for: tabBarController)
    
    let feedNavigationController = makeFeedNavigationController()
    let catalogueNavigationController = makeCatalogueNavigationController()
    
    tabBarController.tabsInfo = [
      TabBarTabInfo(tabKind: .feed, viewController: feedNavigationController),
      TabBarTabInfo(tabKind: .catalogue, viewController: catalogueNavigationController),
      TabBarTabInfo(tabKind: .newLook, viewController: BaseViewController()),
      TabBarTabInfo(tabKind: .collection, viewController: EmptyViewController(title: "Гардероб")),
      TabBarTabInfo(tabKind: .profile, viewController: EmptyViewController(title: "Профиль"))
    ]
    tabBarController.onDidRequestToMakeNewLook = { [weak self] in
      let coordinator = self?.show(NewLookCoordinator.self, animated: true)
      coordinator?.delegate = self
    }
    navigationController.pushViewController(tabBarController, animated: animated)
  }
  
  private func makeFeedNavigationController() -> NavigationController {
    let navigationController = NavigationController()
    let feedCoordinator = FeedCoordinator(navigationController: navigationController,
                                          appDependency: appDependency)
    feedCoordinator.start(animated: false)
    tabCoordinators[.feed] = feedCoordinator
    return navigationController
  }
  
  private func makeCatalogueNavigationController() -> NavigationController {
    let navigationController = NavigationController()
    let catalogueCoordinator = CatalogueCoordinator(navigationController: navigationController,
                                          appDependency: appDependency)
    catalogueCoordinator.start(animated: false)
    tabCoordinators[.catalogue] = catalogueCoordinator
    return navigationController
  }
}

// MARK: - NewLookCoordinatorDelegate

extension TabBarCoordinator: NewLookCoordinatorDelegate {
  func newLookCoordinatorDidFinish(_ coordinator: NewLookCoordinator) {
    navigationController.dismiss(animated: true)
    remove(coordinator)
  }
}
