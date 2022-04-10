//
//  TabBarTabItemView.swift
//  GetOutfit
//

import UIKit

class TabBarTabItemView: UIView, TabBarTabItemProtocol {
  // MARK: - Properties
  
  var onDidTap: ((_ tabKind: TabBarTabKind) -> Void)?
  
  var isSelected = false {
    didSet {
      update()
    }
  }
  
  let tabKind: TabBarTabKind
  
  private let stackView = UIStackView()
  private let iconImageView = UIImageView()
  private let titleLabel = UILabel()
  
  // MARK: - Init
  
  init(tabKind: TabBarTabKind) {
    self.tabKind = tabKind
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Actions
  
  @objc private func didTap() {
    onDidTap?(tabKind)
  }
  
  // MARK: - Setup
  
  private func setup() {
    setupStackView()
    setupIconImageView()
    setupTitleLabel()
    
    addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
  }
  
  private func setupStackView() {
    addSubview(stackView)
    stackView.axis = .vertical
    stackView.spacing = 4
    stackView.alignment = .center
    stackView.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.trailing.equalToSuperview()
    }
  }
  
  private func setupIconImageView() {
    stackView.addArrangedSubview(iconImageView)
    iconImageView.contentMode = .scaleAspectFit
    iconImageView.image = tabKind.icon?.withRenderingMode(.alwaysTemplate)
    iconImageView.snp.makeConstraints { make in
      make.size.equalTo(24)
    }
  }
  
  private func setupTitleLabel() {
    stackView.addArrangedSubview(titleLabel)
    titleLabel.font = .appRegular(size: 10)
    titleLabel.text = tabKind.title
    titleLabel.textColor = .accent
  }
  
  // MARK: - Private methods
  
  private func update() {
    iconImageView.tintColor = isSelected ? .accent : .accentFaded
    titleLabel.textColor = isSelected ? .accent : .accentFaded
  }
}
