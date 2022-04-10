//
//  TabBarController.swift
//  GetOutfit
//

import UIKit

struct TabBarTabInfo {
  let tabKind: TabBarTabKind
  let viewController: UIViewController
}

class TabBarController: UITabBarController, NavigationBarHiding {
  var onDidRequestToMakeNewLook: (() -> Void)?
  
  private let tabBarView = TabBarView()
  
  override var selectedIndex: Int {
    didSet {
      tabBarView.selectedIndex = selectedIndex
    }
  }
  
  override var viewControllers: [UIViewController]? {
    didSet {
      (viewControllers ?? []).forEach { viewController in
        viewController.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0,
                                                               bottom: 24, right: 0)
      }
    }
  }
  
  var tabsInfo: [TabBarTabInfo] = [] {
    didSet {
      update()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  func hideTabBar() {
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
      self.tabBarView.transform = CGAffineTransform(translationX: 0,
                                                    y: self.tabBarView.frame.height + 16)
    } completion: { _ in
      self.tabBarView.isHidden = true
    }
  }
  
  func showTabBar() {
    tabBarView.isHidden = false
    
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
      self.tabBarView.transform = CGAffineTransform(translationX: 0, y: 0)
    }, completion: nil)
  }
  
  private func setup() {
    setupTabBar()
  }
  
  private func setupTabBar() {
    tabBar.alpha = 0
    tabBar.layer.zPosition = -1
    tabBar.isUserInteractionEnabled = false
    
    view.addSubview(tabBarView)
    tabBarView.delegate = self
    tabBarView.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  private func update() {
    viewControllers = tabsInfo.map(\.viewController)
    tabBarView.configure(with: tabsInfo.map(\.tabKind))
  }
}

// MARK: - TabBarViewDelegate

extension TabBarController: TabBarViewDelegate {
  func tabBarView(_ view: TabBarView, didSelectTab tabKind: TabBarTabKind) {
    if tabKind == .newLook {
      onDidRequestToMakeNewLook?()
      return
    }
    
    guard let index = tabsInfo.firstIndex(where: { $0.tabKind == tabKind }) else { return }
    selectedIndex = index
  }
}
