//
//  TabBarView.swift
//  GetOutfit
//

import UIKit

protocol TabBarTabItemProtocol: UIView {
  var onDidTap: ((_ tabKind: TabBarTabKind) -> Void)? { get set }
  var tabKind: TabBarTabKind { get }
}

protocol TabBarViewDelegate: AnyObject {
  func tabBarView(_ view: TabBarView, didSelectTab tabKind: TabBarTabKind)
}

class TabBarView: UIView {
  // MARK: - Properties
  
  weak var delegate: TabBarViewDelegate?
  
  var selectedIndex: Int = 0 {
    didSet {
      update()
    }
  }
  
  private let tabItemsStackView = UIStackView()
  
  // MARK: - Init
  
  init() {
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configure
  
  func configure(with tabKinds: [TabBarTabKind]) {
    tabItemsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    tabKinds.forEach { tabKind in
      let tabItemView: UIView
      if tabKind == .newLook {
        tabItemView = UIView()
        setupNewLookButton()
      } else {
        let itemView = TabBarTabItemView(tabKind: tabKind)
        itemView.onDidTap = { [weak self] tabKind in
          self?.didSelectTab(tabKind)
        }
        tabItemView = itemView
      }
      tabItemsStackView.addArrangedSubview(tabItemView)
    }
    update()
  }
  
  // MARK: - Setup
  
  private func setup() {
    setupContainer()
    setupBorderView()
    setupTabItemsStackView()
  }
  
  private func setupContainer() {
    let blurEffect = UIBlurEffect(style: .regular)
    let visualEffectView = UIVisualEffectView(effect: blurEffect)
    visualEffectView.backgroundColor = .white.withAlphaComponent(0.8)
    addSubview(visualEffectView)
    visualEffectView.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalToSuperview()
      make.top.equalToSuperview().inset(16)
    }
  }
  
  private func setupTabItemsStackView() {
    addSubview(tabItemsStackView)
    tabItemsStackView.distribution = .fillEqually
    tabItemsStackView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(16)
      make.leading.trailing.equalToSuperview()
      make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
      make.height.equalTo(56)
    }
  }
  
  private func setupBorderView() {
    let borderView = UIView()
    borderView.backgroundColor = .shade0
    addSubview(borderView)
    borderView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalToSuperview().offset(15)
      make.height.equalTo(1)
    }
  }
  
  private func setupNewLookButton() {
    subviews.filter { $0 is TabBarTabNewLookView }.forEach { $0.removeFromSuperview() }
    let newLookButton = TabBarTabNewLookView()
    newLookButton.onDidTap = { [weak self] tabKind in
      guard let self = self else { return }
      self.delegate?.tabBarView(self, didSelectTab: tabKind)
    }
    addSubview(newLookButton)
    newLookButton.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview()
    }
  }
  
  // MARK: - Private methods
  
  private func didSelectTab(_ tabKind: TabBarTabKind) {
    delegate?.tabBarView(self, didSelectTab: tabKind)
  }
  
  private func update() {
    guard let tabItemView = tabItemsStackView.arrangedSubviews.element(at: selectedIndex)
            as? TabBarTabItemProtocol, tabItemView.tabKind != .newLook else { return }
    tabItemsStackView.arrangedSubviews.forEach { ($0 as? TabBarTabItemView)?.isSelected = false }
    (tabItemView as? TabBarTabItemView)?.isSelected = true
  }
}
