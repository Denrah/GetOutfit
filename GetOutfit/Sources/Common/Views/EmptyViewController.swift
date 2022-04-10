//
//  EmptyViewController.swift
//  GetOutfit
//

import UIKit

class EmptyViewController: BaseViewController {
  private let titleLabel = UILabel()
  
  init(title: String) {
    super.init(nibName: nil, bundle: nil)
    titleLabel.text = title
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(titleLabel)
    titleLabel.font = .appRegular()
    titleLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
}
