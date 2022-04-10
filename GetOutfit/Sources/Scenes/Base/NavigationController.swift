//
//  NavigationController.swift
//  GetOutfit
//

import UIKit

class NavigationController: UINavigationController {
  override var preferredStatusBarStyle: UIStatusBarStyle {
      return .darkContent
  }

  private var popObservers: [NavigationPopObserver] = []

  init() {
    super.init(nibName: nil, bundle: nil)
    configureDefaultNavigationBarAppearance()
    delegate = self
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func configureDefaultNavigationBarAppearance() {
    let titleAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black,
                                                          .font: UIFont.appRegular(size: 16) ?? .boldSystemFont(ofSize: 16)]

    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = .white
    appearance.shadowColor = .clear
    appearance.shadowImage = UIImage()
    appearance.titleTextAttributes = titleAttributes
    navigationBar.standardAppearance = appearance
    navigationBar.scrollEdgeAppearance = appearance

    navigationBar.barTintColor = .white
    navigationBar.isTranslucent = false
    navigationBar.tintColor = .accent
    navigationBar.titleTextAttributes = titleAttributes
    navigationBar.shadowImage = UIImage()
  }

  func addPopObserver(for viewController: UIViewController, coordinator: Coordinator) {
    let observer = NavigationPopObserver(observedViewController: viewController, coordinator: coordinator)
    popObservers.append(observer)
  }

  func removeAllPopObservers() {
    popObservers.removeAll()
  }
}

// MARK: - UINavigationControllerDelegate

extension NavigationController: UINavigationControllerDelegate {
  func navigationController(_ navigationController: UINavigationController,
                            willShow viewController: UIViewController, animated: Bool) {
    if viewController is NavigationBarHiding {
      navigationController.setNavigationBarHidden(true, animated: animated)
    } else {
      navigationController.setNavigationBarHidden(false, animated: animated)
    }
    
    if viewController.hidesBottomBarWhenPushed {
      (parent as? TabBarController)?.hideTabBar()
    } else {
      (parent as? TabBarController)?.showTabBar()
    }
  }

  func navigationController(_ navigationController: UINavigationController,
                            didShow viewController: UIViewController, animated: Bool) {
    popObservers.forEach { observer in
      if !navigationController.viewControllers.contains(observer.observedViewController) {
        observer.didObservePop()
        popObservers.removeAll { $0 === observer }
      }
    }
  }
}
