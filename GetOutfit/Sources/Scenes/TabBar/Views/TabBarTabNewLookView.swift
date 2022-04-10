//
//  TabBarTabNewLookView.swift
//  GetOutfit
//

import UIKit

class TabBarTabNewLookView: UIView, TabBarTabItemProtocol {
  // MARK: - Properties
  
  var onDidTap: ((TabBarTabKind) -> Void)?
  
  let tabKind: TabBarTabKind = .newLook
  
  private let imageView = UIImageView()
  private let titleLabel = UILabel()
  
  // MARK: - Init
  
  init() {
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Actions
  
  @objc private func didTap() {
    onDidTap?(.newLook)
  }
  
  // MARK: - Setup
  
  private func setup() {
    setupContainer()
    setupImageView()
    setupTitleLabel()
  }
  
  private func setupContainer() {
    backgroundColor = .accent
    layer.cornerRadius = 16
    layer.cornerCurve = .continuous
    snp.makeConstraints { make in
      make.size.equalTo(56)
    }
  }
  
  private func setupImageView() {
    addSubview(imageView)
    imageView.image = .init(.newLook)?.withRenderingMode(.alwaysTemplate)
    imageView.tintColor = .white
    imageView.contentMode = .scaleAspectFit
    imageView.snp.makeConstraints { make in
      make.size.equalTo(24)
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().offset(8)
    }
    
    addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
  }
  
  private func setupTitleLabel() {
    addSubview(titleLabel)
    titleLabel.font = .appRegular(size: 10)
    titleLabel.text = "Новый"
    titleLabel.textColor = .white
    titleLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview().inset(6)
    }
  }
}
